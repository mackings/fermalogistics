import 'package:dotted_line/dotted_line.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sizer/sizer.dart'; // Assuming you are using the sizer package
import 'dart:io';

class Newrequest extends ConsumerStatefulWidget {
  const Newrequest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewrequestState();
}

class _NewrequestState extends ConsumerState<Newrequest> {
  TextEditingController product = TextEditingController();
  TextEditingController packages = TextEditingController();
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
    });
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
              CustomTextFormField(
                labelText: "Name of Product",
                hintText: "Enter name of Product",
                controller: product,
                onChanged: (p0) {},
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                labelText: "Number of Packages",
                hintText: "Enter number of Packages",
                controller: packages,
                onChanged: (p0) {},
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Upload Image of Product'),
                  SizedBox(
                    height: 2.h,
                  ),
                  DottedBorder(
                    radius: Radius.circular(15),
                    color: Colors.grey,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    child: Container(
                      height: 23.h,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF5F6),
                       // borderRadius: BorderRadius.circular(15),
                        image: _pickedImage != null
                            ? DecorationImage(
                                image: FileImage(File(_pickedImage!.path)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Stack(
                        children: [
                          if (_pickedImage == null) ...[
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.cloud_upload),
                                  CustomText(text: 'Upload your request here'),
                                  CustomText(
                                    text: 'JPG & PNG Formats, 5MB max file size',
                                    fontSize: 8.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      height: 7.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        color: btncolor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          text: 'Upload Here',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            Positioned(
        
                              bottom: 2.h,
                              left: (MediaQuery.of(context).size.width - 40) / 4,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  height: 7.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: 'Change Image',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
        
        SizedBox(height: 2.h,),
        
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Add additional info"),
                      SizedBox(height: 2.h,),
                      Container(
                        height: 13.h,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5,color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              
                            ),
                            ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 2.h,),

                  Row(
                    children: [
                      Icon(Icons.add),
                      Text("Add Another Request")
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  DottedLine(),
                  SizedBox(height: 2.h,),

                   Row(
                    children: [
                      Icon(Icons.error),
                      CustomText(text: "Your request will be taken up by our agents",fontSize: 7.sp,)
                    ],
                  ),

                  SizedBox(height: 5.h,),

                  CustomButton(text: "Place a Request", onPressed: (){}),

                  SizedBox(height: 4.h,),

                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
