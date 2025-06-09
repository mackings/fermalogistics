
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:sizer/sizer.dart';



class ScanCode extends StatefulWidget {
  const ScanCode({super.key});

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  String result = "";

  Future<void> scanBarcode() async {
    try {
      String? res = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Scan Barcode',
          centerTitle: true,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 2000,
        cameraFace: CameraFace.back,
      );

      if (res != null && res.isNotEmpty && res != "-1") {
        setState(() {
          result = res;
        });

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Icon(Icons.qr_code_scanner,
                        size: 50, color: Colors.green),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Scanned Barcode',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                      text: "Done",
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            );
          },
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get barcode: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Scan Barcode'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              const Icon(Icons.qr_code_2, size: 190),
              SizedBox(height: 20.h),
              CustomButton(
                text: "Scan",
                onPressed: scanBarcode,
              ),
              SizedBox(height: 2.h),
              CustomText(
                text: "Kindly hold the camera still at the barcode",
                fontSize: 8.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
