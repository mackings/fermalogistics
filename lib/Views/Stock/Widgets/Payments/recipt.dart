import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SuccessDetailsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Receipt"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sender Details
            _buildSectionContainer(
              title: "Sender Details",
              children: [
                _buildDetailRow('Name', senderName),
                _buildDetailRow('Phone Number', phoneNumber),
                _buildDetailRow('Email', email),
                _buildDetailRow('Pickup Address', pickupAddress),
              ],
            ),
            const SizedBox(height: 16),

            // Receiver Details
            _buildSectionContainer(
              title: "Receiver Details",
              children: [
                _buildDetailRow('Name', receiverName),
                _buildDetailRow('Phone Number', receiverPhoneNumber),
                _buildDetailRow('Email', receiverEmail),
                _buildDetailRow('Address', receiverAddress),
              ],
            ),
            const SizedBox(height: 16),

            // Shipping Details
            _buildSectionContainer(
              title: "Shipping Details",
              children: [
                _buildDetailRow('Shipping Fee', '\$${shippingFee.toStringAsFixed(2)}'),
                _buildDetailRow('Status', status),
                _buildDetailRow('Tracking Number', trackingNumber),
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
                    onPressed: () {
                      // Download action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

