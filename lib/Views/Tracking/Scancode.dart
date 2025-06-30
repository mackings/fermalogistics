import 'package:getnamibia/Views/Tracking/Api/Scanservice.dart';
import 'package:getnamibia/Views/Tracking/Model/scanmodel.dart';
import 'package:getnamibia/Views/Tracking/widgets/scanmodal.dart';
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
  String? extractProductId(String url) {
    final uri = Uri.tryParse(url);
    if (uri != null && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }
    return null;
  }

  Future<void> scanBarcode() async {
    try {
      String? res = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Scan Barcodes',
          centerTitle: true,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 2000,
        cameraFace: CameraFace.back,
      );

      if (res != null && res.isNotEmpty && res != "-1") {
        final productId = extractProductId(res);

        if (productId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid barcode format.')),
          );
          return;
        }

        final apiService = ProductApiService();
        final Product? product = await apiService.fetchProductById(productId);

        if (product == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch product info.')),
          );
          return;
        }


showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.white,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
  ),
  builder: (context) => ProductDetailsModal(product: product),
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
      appBar: AppBar(title: CustomText(text: 'Scan Barcode')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              const Icon(Icons.qr_code_2, size: 190),
              SizedBox(height: 20.h),
              CustomButton(text: "Scan", onPressed: scanBarcode),
              SizedBox(height: 2.h),
              CustomText(
                text: "Kindly hold the camera still at the barcode",
                fontSize: 8.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

