
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryInfoCard extends StatelessWidget {
  final String deliveryTime;
  final String deliveryDate;
  final String customerName;
  final String customerPhone;
  final String pickupLocation;
  final String dropoffLocation;
  final String status;
  final String profileImageUrl;
  final VoidCallback onStatusButtonTap;
  final Color? buttonColor; // Optional button color
  final String? buttonText; // Optional button text

  const DeliveryInfoCard({
    Key? key,
    required this.deliveryTime,
    required this.deliveryDate,
    required this.customerName,
    required this.customerPhone,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.status,
    required this.profileImageUrl,
    required this.onStatusButtonTap,
    this.buttonColor, // Optional
    this.buttonText, // Optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Estimated Delivery Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estimated Delivery Time",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  deliveryTime,
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  deliveryDate,
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Customer Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName,
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        customerPhone,
                        style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.mail_outline, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(),

            // Pickup and Drop-off
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Picked up from",
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        pickupLocation,
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.local_shipping, color: Colors.black),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Drop off",
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        dropoffLocation,
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Status Button with Custom Function
            GestureDetector(
              onTap: onStatusButtonTap,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: buttonColor ?? Colors.green, // Default to green if not provided
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    buttonText ?? "In Transit", // Default text if not provided
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


