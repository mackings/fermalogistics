import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/delivery.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';




class PickupDetailsPage extends StatelessWidget {
  final SendOrder upcomingOrder; // Accept the entire SendOrder object

  const PickupDetailsPage({
    Key? key,
    required this.upcomingOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the first item from the cart
    CartItem firstItem = upcomingOrder.cartItems.isNotEmpty
        ? upcomingOrder.cartItems.first
        : CartItem(
            productId: '',
            quantity: 0,
            price: 0.0,
            vatAmount: 0.0,
            picture: '',
            sku: '',
            productName: 'No Product',
            subTotal: 0.0,
          );

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Pickup details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://via.placeholder.com/150"), // Replace with actual profile image
                    radius: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          upcomingOrder.userId.fullName,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          upcomingOrder.userId.phoneNumber,
                          style: GoogleFonts.inter(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.phone, color: Colors.green),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.message, color: Colors.blue),
                      onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Product Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      firstItem.picture.isNotEmpty
                          ? firstItem.picture
                          : "https://via.placeholder.com/150", // Default image if empty
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstItem.productName,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${firstItem.price.toStringAsFixed(2)}",
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "x${firstItem.quantity}",
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Divider(),

            const SizedBox(height: 16),

            // Order Number
            Text(
              "Order number: #${upcomingOrder.orderId}",
              style:
                  GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "Use this ID at warehouse to pickup order instead of customer’s name",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Arrival Instructions
            Text(
              "Upon Arrival",
              style:
                  GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "Remember to check receipts and make sure it corresponds with the order.",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 165),

CustomButton(
  text: "Confirm Pickup",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Pickupdelivery(
          upcomingOrder: upcomingOrder, // Pass the order data
        ),
      ),
    );
  },
),

          ],
        ),
      ),
    );
  }
}
