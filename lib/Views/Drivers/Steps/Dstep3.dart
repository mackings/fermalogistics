import 'package:getnamibia/Views/Drivers/widgets/filecard.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
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
                    selectedFiles["ridersCard"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("ridersCard");
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
                    selectedFiles["motLicense"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("motLicense");
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
                    selectedFiles["driverLicense"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("driverLicense");
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
                    selectedFiles["exteriorPhotoOfYourCar"] = file.path;  // Store file path instead of PlatformFile
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
                    selectedFiles["interiorPhotoOfYourCar"] = file.path;  // Store file path instead of PlatformFile
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
                    selectedFiles["proofOfOwnerCertification"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("proofOfOwnerCertification");
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
                    selectedFiles["certificateOfRoadWorthiness"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("certificateOfRoadWorthiness");
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
                    selectedFiles["insuranceCertification"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("insuranceCertification");
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
                    selectedFiles["LASRRACard"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("LASRRACard");
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
                    selectedFiles["LASDRICard"] = file.path;  // Store file path instead of PlatformFile
                  } else {
                    selectedFiles.remove("LASDRICard");
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
                  print('$key: $value');  // Print the file path (not name, since you are storing paths now)
                });
                // Pass selected files as paths
                widget.onComplete(selectedFiles);
              },
            ),
          ],
        ),
      ),
    );
  }
}

