import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class NewDeliverySlideCard extends StatelessWidget {
  
  final String title;
  final String deliveryTime;
  final String pickupLocation;
  final VoidCallback onSeeItems;
  final VoidCallback onSlideConfirm;

  const NewDeliverySlideCard({
    Key? key,
    required this.title,
    required this.deliveryTime,
    required this.pickupLocation,
    required this.onSeeItems,
    required this.onSlideConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and See Items Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: onSeeItems,
                      child: Row(
                        children: [
                          Icon(Icons.list_alt, size: 16, color: Colors.grey[700]),
                          SizedBox(width: 4),
                          Text(
                            "See Items",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              // Delivery Time
              Text(
                "To be delivered by $deliveryTime",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 12),
              Divider(height: 1, color: Colors.grey.shade300),
              SizedBox(height: 12),
              // Pickup Location
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red.shade100,
                    child: Icon(Icons.location_pin, color: Colors.red, size: 18),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pickup", style: GoogleFonts.inter(fontSize: 12, color: Colors.red)),
                      Text(
                        pickupLocation,
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Slide to confirm button
              GestureDetector(
                onTap: onSlideConfirm,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Slide after arrival at pickup",
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
