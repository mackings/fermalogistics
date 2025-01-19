import 'dart:io';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class FacialVerificationWidget extends StatefulWidget {
  final Map<String, dynamic> formData; // Receive the gathered data here
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

  // Function to pick an image from the camera
  Future<void> _takePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _uploadedImage = File(pickedFile.path);
      });
    }
  }

  // Function to pick an image from the gallery
  Future<void> _retakePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _uploadedImage = File(pickedFile.path);
      });
    }
  }

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

    // Merge the uploaded image into formData
    final Map<String, dynamic> updatedFormData = {
      ...widget.formData, // Include all previously gathered data
      'facialVerificationPhoto': _uploadedImage!, // Add uploaded photo
    };

    // Call the onComplete callback to pass the final data
    widget.onComplete(updatedFormData);

    // For example, print the updated data
    print("Final form data: $updatedFormData");

    // Make the API call
    await _makeApiCall(updatedFormData);
  }

  Future<void> _makeApiCall(Map<String, dynamic> formData) async {
    final url =
        "https://fama-logistics.onrender.com/api/v1/dropshipperShipment/calculationInvolvedShipment";

    final headers = {
      'Authorization': 'Bearer YOUR_TOKEN_HERE',
    };

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      // Add regular form data
      formData.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        }
      });

      // Add uploaded photo
      if (formData['facialVerificationPhoto'] is File) {
        final file = formData['facialVerificationPhoto'] as File;
        request.files.add(
          http.MultipartFile(
            'facialVerificationPhoto',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ),
        );
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode == 201) {
        print("Data submitted successfully.");
      } else {
        print("Failed to submit data. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during API call: $e");
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
                text: 'Continue',
                onPressed: _submitData,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
