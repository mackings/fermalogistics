import 'dart:convert';
import 'dart:io';
import 'package:getnamibia/Views/Drivers/widgets/modal.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;



class FacialVerificationWidget extends StatefulWidget {
  final Map<String, dynamic> formData;
  final void Function(Map<String, dynamic> data) onComplete;

  const FacialVerificationWidget({
    required this.formData,
    required this.onComplete,
    Key? key,
  }) : super(key: key);

  @override
  State<FacialVerificationWidget> createState() =>
      _FacialVerificationWidgetState();
}

class _FacialVerificationWidgetState extends State<FacialVerificationWidget> {

  File? _uploadedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false; // Track loading state

  // Function to pick an image from the camera
  Future<void> _takePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _uploadedImage = File(pickedFile.path);
      });
    }
  }

  // Function to pick an image from the gallery
  Future<void> _retakePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _uploadedImage = File(pickedFile.path);
      });
    }
  }


   Future<String?> _retrieveUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }

  // Submit the gathered data
  Future<void> _submitData() async {
    if (_uploadedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please upload a photo before continuing."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Prepare the updated formData
    final Map<String, dynamic> updatedFormData = {
      ...widget.formData, // Include previously gathered data
      'faceVerification': _uploadedImage!.path, // Use file path instead of File/PlatformFile
    };

    // Log formData to verify its structure
    print("Updated formData before API call: $updatedFormData");
    print(_uploadedImage!.path);

    // Pass formData to the onComplete callback
    widget.onComplete(updatedFormData);

    // Start loading
    setState(() {
      isLoading = true;
    });

    // Make the API call
    await _makeApiCall(updatedFormData);
  }

  // Make API call to submit data
  Future<void> _makeApiCall(Map<String, dynamic> formData) async {
    final url = "https://fama-logistics.onrender.com/api/v1/deliveryPersonnel/uploadDocuments";

    try {
      // Retrieve token
      final token = await _retrieveUserToken();
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: Token not found."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      // Add regular form data (strings)
      formData.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        }
      });

      // Add file uploads
      Future<void> addFileToRequest(String key, dynamic value) async {
        if (value is String &&
            (value.endsWith('.jpg') || value.endsWith('.png') || value.endsWith('.jpeg'))) {
          final file = File(value);
          if (await file.exists()) {
            request.files.add(
              http.MultipartFile(
                key,
                file.readAsBytes().asStream(),
                file.lengthSync(),
                filename: value.split('/').last,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: File not found at $value."),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
      }

      if (formData.containsKey('faceVerification')) {
        await addFileToRequest('faceVerification', formData['faceVerification']);
      }
      if (formData.containsKey('ridersCard')) {
        await addFileToRequest('ridersCard', formData['ridersCard']);
      }
      if (formData.containsKey('motLicense')) {
        await addFileToRequest('motLicense', formData['motLicense']);
      }

      // Send the request
      final response = await request.send();

      // Stop loading when the response is received
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        showSuccessModalBottomSheet(context);
      } else {
        final responseError = await response.stream.bytesToString();
        final errorMessage = jsonDecode(responseError)['message'] ?? "Unknown error.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(" $errorMessage"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error making API call: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText(
              text: "Facial Verification",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),

            SizedBox(height: 8),

            CustomText(
              text: "1. You must replicate the exact pose on the left picture.",
              fontSize: 7.sp,
              fontWeight: FontWeight.w400,
            ),

            CustomText(
              text: "2. Your face must be clearly visible",
              fontSize: 7.sp,
              fontWeight: FontWeight.w400,
            ),

            SizedBox(height: 4.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('assets/pose.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: _uploadedImage == null
                      ? Center(
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _uploadedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),

              ],
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                
                CustomText(
                  text: "It will be visible on your profile",
                  fontSize: 7.sp,
                  color: Colors.grey,
                ),
              ],
            ),
            
            SizedBox(height: 16),

            if (_uploadedImage == null)

              CustomButton(
                text: "Take Photo",
                onPressed: _takePhoto,
              ),


            if (_uploadedImage != null) ...[

              GestureDetector(
                onTap: _retakePhoto,
                child: Container(
                  height: 7.h,
                  width: MediaQuery.of(context).size.width - 20.w,
                  child: Center(
                    child: CustomText(
                      text: "Take a new photo", 
                      color: Colors.red,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 246, 246),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 16),

              CustomButton(
                text: isLoading ? "Uploading Data..." : 'Continue',
                onPressed: isLoading ? null : _submitData, // Disable button when loading
              ),
              
            ],
          ],
        ),
      ),
    );
  }
}

