import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SuccessDetailsPage extends StatefulWidget {
  final String senderName;
  final String phoneNumber;
  final String email;
  final String pickupAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverEmail;
  final String receiverAddress;
  final double shippingFee;
  final String status;
  final String trackingNumber;

  const SuccessDetailsPage({
    Key? key,
    required this.senderName,
    required this.phoneNumber,
    required this.email,
    required this.pickupAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverEmail,
    required this.receiverAddress,
    required this.shippingFee,
    required this.status,
    required this.trackingNumber,
  }) : super(key: key);

  @override
  State<SuccessDetailsPage> createState() => _SuccessDetailsPageState();
}

class _SuccessDetailsPageState extends State<SuccessDetailsPage> {


bool isDownloading = false;


Future<void> _downloadReceiptAsPdf() async {
  setState(() {
    isDownloading = true;
  });

  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Text(
          'E-Receipt',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20),

        pw.Text('Sender Details', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Name: ${widget.senderName}'),
        pw.Text('Phone Number: ${widget.phoneNumber}'),
        pw.Text('Email: ${widget.email}'),
        pw.Text('Pickup Address: ${widget.pickupAddress}'),
        pw.SizedBox(height: 15),

        pw.Text('Receiver Details', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Name: ${widget.receiverName}'),
        pw.Text('Phone Number: ${widget.receiverPhoneNumber}'),
        pw.Text('Email: ${widget.receiverEmail}'),
        pw.Text('Address: ${widget.receiverAddress}'),
        pw.SizedBox(height: 15),

        pw.Text('Shipping Details', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Shipping Fee: \$${widget.shippingFee.toStringAsFixed(2)}'),
        pw.Text('Status: ${widget.status}'),
        pw.Text('Tracking Number: ${widget.trackingNumber}'),
      ],
    ),
  );

  try {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        try {
          return pdf.save();
        } catch (e) {
          print('🛑 PDF generation error: $e');
          rethrow;
        }
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receipt downloaded successfully')),
    );
  } catch (e) {
    print('❌ Download error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to download receipt')),
    );
  } finally {
    setState(() {
      isDownloading = false;
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: "E-Recipt")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender Details
            _buildSectionContainer(
              title: "Sender Details",
              children: [
                _buildDetailRow('Name', widget.senderName),
                _buildDetailRow('Phone Number', widget.phoneNumber),
                _buildDetailRow('Email', widget.email),
                _buildDetailRow('Pickup Address', widget.pickupAddress),
              ],
            ),
            const SizedBox(height: 16),

            // Receiver Details
            _buildSectionContainer(
              title: "Receiver Details",
              children: [
                _buildDetailRow('Name', widget.receiverName),
                _buildDetailRow('Phone Number', widget.receiverPhoneNumber),
                _buildDetailRow('Email', widget.receiverEmail),
                _buildDetailRow('Address', widget.receiverAddress),
              ],
            ),
            const SizedBox(height: 16),

            // Shipping Details
            _buildSectionContainer(
              title: "Shipping Details",
              children: [
                _buildDetailRow(
                  'Shipping Fee',
                  '\$${widget.shippingFee.toStringAsFixed(2)}',
                ),
                _buildDetailRow('Status', widget.status),
                _buildDetailRow('Tracking Number', widget.trackingNumber),
              ],
            ),
            const SizedBox(height: 24),

            // A'ction Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Share receipt action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Share Receipt',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

Expanded(
  child: ElevatedButton(
    onPressed: isDownloading ? null : _downloadReceiptAsPdf,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: isDownloading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : const Text(
            'Download',
            style: TextStyle(color: Colors.white),
          ),
  ),
),


              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a section container
  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  // Helper method to create a detail row
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
