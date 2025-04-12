import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sizer/sizer.dart';

class ScanCode extends StatefulWidget {
  const ScanCode({super.key});

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  String barcode = "";

  Future<void> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // COLOR_CODE
        "Cancel", // CANCEL_BUTTON_TEXT
        true, // isShowFlashIcon
        ScanMode.BARCODE,
      );

      if (barcodeScanRes != '-1') {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
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
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.close, size: 28),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Icon(Icons.qr_code_scanner,
                        size: 50, color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Scanned Barcode',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      barcodeScanRes,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 25),
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
      } else {
        // Optionally show a snackbar or message
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
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Icon(
                Icons.qr_code_2,
                size: 190,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                  text: "Scan ",
                  onPressed: () {
                    scanBarcode();
                  }),
              SizedBox(
                height: 2.h,
              ),
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
