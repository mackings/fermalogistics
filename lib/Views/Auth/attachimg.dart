import 'dart:convert';
import 'dart:io';

import 'package:fama/Views/Auth/addaddress.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AttachImg extends ConsumerStatefulWidget {
  const AttachImg({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttachImgState();
}

class _AttachImgState extends ConsumerState<AttachImg> {
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = image;
    });
  }

  Future<void> _uploadImage() async {
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final Uri url = Uri.parse(
        "https://fama-logistics.onrender.com/api/v1/user/uploadProfilePicture");
    final request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(
          await http.MultipartFile.fromPath('picture', _pickedImage!.path));

    try {
      final http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print(request.headers);
      print(request.files);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        print(responseData);
        print(response.stream);

        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Addaddress()),
        );
      } else {
        print(responseBody);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload Failed: ${responseBody}')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              ListTile(
                title: CustomText(
                  text: "Select Profile Picture",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: CustomText(
                  text: "We love a good looking profile, let's make one!",
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.h),
              Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: _pickedImage != null
                            ? Image.file(
                                File(_pickedImage!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/attach.png',
                                width: 50,
                                height: 50,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  CustomText(text: "Choose Image"),
                  SizedBox(height: 30.h),
                  CustomButton(
                    text: "Continue",
                    onPressed: _uploadImage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
