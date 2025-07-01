import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getnamibia/Views/Tracking/widgets/dialogscan.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AcceptProductModal extends StatefulWidget {
  final String productId;
  final BuildContext parentContext;

  const AcceptProductModal({
    Key? key,
    required this.productId,
    required this.parentContext, // ✅ include parentContext here
  }) : super(key: key);

  @override
  State<AcceptProductModal> createState() => _AcceptProductModalState();
}


class _AcceptProductModalState extends State<AcceptProductModal> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  File? _signatureImage;
  bool _loading = false;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      final decoded = json.decode(userData);
      return decoded['token'];
    }
    return null;
  }

  Future<void> _pickSignature() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _signatureImage = File(picked.path);
      });
    }
  }



Future<void> _submitAcceptance() async {
  final token = await _getToken();
  if (token == null) {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 500));
    ScaffoldMessenger.of(widget.parentContext).showSnackBar(
      const SnackBar(content: Text('Token not found')),
    );
    return;
  }

  if (_quantityController.text.isEmpty ||
      _remarksController.text.isEmpty ||
      _signatureImage == null) {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 500));
    ScaffoldMessenger.of(widget.parentContext).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
    );
    return;
  }

  setState(() => _loading = true);

  final uri = Uri.parse(
    'https://fama-logistics-ljza.onrender.com/api/v1/transfer/scannedAcceptProductTransfer/${widget.productId}',
  );

  try {
    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
     // ..fields['remarks'] = _remarksController.text
      ..files.add(
        await http.MultipartFile.fromPath(
          'receiverSignature',
          _signatureImage!.path,
        ),
      );

    // Log request
    print("=== REQUEST ===");
    print("URL: $uri");
    print("Headers: ${request.headers}");
    print("Fields: ${request.fields}");
    print("File Path: ${_signatureImage!.path}");

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    // Log response
    print("=== RESPONSE ===");
    print("Status Code: ${response.statusCode}");
    print("Body: $resBody");

setState(() => _loading = false);
Navigator.pop(context);
final decodedBody = json.decode(resBody);
final errorMessage = decodedBody['message'] ?? 'Unknown error';

Future.delayed(const Duration(milliseconds: 300), () async{
if (response.statusCode == 200) {
  await showResponseDialog(
    context: widget.parentContext,
    title: 'Success',
    message: '✅ Product accepted successfully',
    isSuccess: true,
  );
} else {
await showResponseDialog(
  context: widget.parentContext,
  title: 'Failed',
  message: ' $errorMessage',
  isSuccess: false,
);
}

});

  } catch (e) {
    setState(() => _loading = false);
    Navigator.pop(context);
    await Future.delayed(const Duration(seconds: 60));
    print("=== ERROR ===");
    print(e);
    ScaffoldMessenger.of(widget.parentContext).showSnackBar(
      const SnackBar(content: Text("🚫 An error occurred. Please try again.")),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: "Accept Product Transfer",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
    
            // Quantity Received
            CustomTextFormField(
              labelText: "Quantity Received *",
              hintText: "Enter quantity",
              controller: _quantityController,
              onChanged: (value) {},
            ),
            const SizedBox(height: 12),
    
            // Remarks
            CustomTextFormField(
              labelText: "Remarks *",
              hintText: "Enter remarks about product condition",
              controller: _remarksController,
              onChanged: (value) {},
            ),
            const SizedBox(height: 12),
    
            // Signature Picker
            CustomText(
              text: "Receiver Signature *",
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            const SizedBox(height: 6),
    
            GestureDetector(
              onTap: _pickSignature,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child:
                    _signatureImage == null
                        ? const Center(
                          child: Icon(Icons.upload_file, color: Colors.grey),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _signatureImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
            ),
    
            const SizedBox(height: 20),
    
            _loading
                ? const Center(child: CircularProgressIndicator(color: Colors.red,))
                : CustomButton(text: "Submit", onPressed: _submitAcceptance),
          ],
        ),
      ),
    );
  }
}
