import 'package:fama/Views/Drivers/widgets/filecard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DStepForm3 extends StatefulWidget {

  final void Function(Map<String, dynamic> data) onComplete;

  const DStepForm3({required this.onComplete, Key? key}) : super(key: key);

  @override
  State<DStepForm3> createState() => _DStepForm3State();
}

class _DStepForm3State extends State<DStepForm3> {
  final Map<String, dynamic> selectedFiles = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            CustomText(
              text: "Documents",
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            CustomText(
              text:
                  "We are legally required to get your legal signed documents to get you started",
              fontSize: 7.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Rider's Card (Motorbikers only)",
              subtitle: 'Upload your government-issued rider\'s card here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Rider's Card"] = file;
                  } else {
                    selectedFiles.remove("Rider's Card");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "MOT License (Motorbikers only)",
              subtitle: 'Upload your government-issued rider\'s card here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["MOT License"] = file;
                  } else {
                    selectedFiles.remove("MOT License");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Driver's License",
              subtitle: 'Upload your government-issued driver\'s license here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Driver's License"] = file;
                  } else {
                    selectedFiles.remove("Driver's License");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Exterior car photo",
              subtitle: 'Upload an exterior photo of your car here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Exterior car photo"] = file;
                  } else {
                    selectedFiles.remove("Exterior car photo");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Interior car photo",
              subtitle: 'Upload an interior photo of your car here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Interior car photo"] = file;
                  } else {
                    selectedFiles.remove("Interior car photo");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Proof of ownership",
              subtitle: 'Upload proof of ownership of your vehicle here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Proof of ownership"] = file;
                  } else {
                    selectedFiles.remove("Proof of ownership");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Certificate of roadworthiness",
              subtitle: 'Upload your certificate of roadworthiness here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Certificate of roadworthiness"] = file;
                  } else {
                    selectedFiles.remove("Certificate of roadworthiness");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "Vehicle insurance certificate",
              subtitle: 'Upload your vehicle insurance certificate here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["Vehicle insurance certificate"] = file;
                  } else {
                    selectedFiles.remove("Vehicle insurance certificate");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "LASRRA Card",
              subtitle: 'Upload your LASRRA card here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["LASRRA Card"] = file;
                  } else {
                    selectedFiles.remove("LASRRA Card");
                  }
                });
              },
            ),
            SizedBox(height: 2.h),
            FileUploadWidget(
              title: "LASDRI Card",
              subtitle: 'Upload your LASDRI card here',
              onFileSelected: (file) {
                setState(() {
                  if (file != null) {
                    selectedFiles["LASDRI Card"] = file;
                  } else {
                    selectedFiles.remove("LASDRI Card");
                  }
                });
              },
            ),
            SizedBox(height: 5.h),

CustomButton(
  text: 'Continue',
  onPressed: () {
    print('All selected files:');
    selectedFiles.forEach((key, value) {
      print('$key: ${value.name}');
    });
    // Pass selected files to the parent
    widget.onComplete(selectedFiles);
  },
),

          ],
        ),
      ),
    );
  }
}
