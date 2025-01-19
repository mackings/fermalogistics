
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

  TextEditingController licsense = TextEditingController();


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
                if (file != null) {
                  print('Selected file: ${file.name}');
                } else {
                  print('No file selected');
                }
              },
            ),

            SizedBox(height: 5.h),

            CustomButton(
              text: 'Continue',
              onPressed: () {
                widget.onComplete({
                  // Handle collected data here
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
