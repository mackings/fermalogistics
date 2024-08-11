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
        ScanMode.BARCODE, // scanMode
      );
      setState(() {
        barcode = barcodeScanRes != '-1' ? barcodeScanRes : 'Scan cancelled';
      });
    } catch (e) {
      setState(() {
        barcode = 'Failed to get barcode: $e';
      });
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
              SizedBox(height: 15.h,),

              Icon(Icons.qr_code_2,size: 190,),
              SizedBox(height: 20.h,),

              CustomButton(
                  text: "Scan ",
                  onPressed: () {
                    scanBarcode();
                  }),
                  SizedBox(height: 2.h,),

                  CustomText(text: "Kindly hold the camera still at the barcode",
                  fontSize: 8.sp,)
            ],
          ),
        ),
      ),
    );
  }
}
