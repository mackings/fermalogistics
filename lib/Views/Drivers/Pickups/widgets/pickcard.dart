import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewDeliveryCard extends StatelessWidget {
  final String title;
  final String deliveryTime;
  final String pickupLocation;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onSeeItems;

  const NewDeliveryCard({
    Key? key,
    required this.title,
    required this.deliveryTime,
    required this.pickupLocation,
    required this.onAccept,
    required this.onDecline,
    required this.onSeeItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
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
              SizedBox(height: 4),
              // Delivery Time
              Text(
                "To be delivered by $deliveryTime",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 12),
              Divider(),
              SizedBox(height: 5),

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
              // Accept & Decline Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onDecline,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Decline", style: GoogleFonts.inter()),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Accept", style: GoogleFonts.inter()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
