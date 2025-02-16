import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showDeliveryCompletedSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Green Check Icon
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 16),
        
              // Title
              Text(
                "Delivery Completed!",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
        
              // Subtitle
              Text(
                "You have successfully delivered the order to the customer",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
        
              // Rate Delivery Experience Button
              ElevatedButton(
                onPressed: () {
                  // Handle rating action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Rate Delivery Experience",
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
        
              // Go to Home Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Close Bottom Sheet
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Go to Home",
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.red),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
