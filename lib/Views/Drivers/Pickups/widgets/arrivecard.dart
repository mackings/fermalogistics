
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ArrivalCard extends StatefulWidget {
  final String title;
  final String deliveryTime;
  final String pickupLocation;
  final VoidCallback onSeeItems;
  final VoidCallback onSlideComplete; // Function to call when tapped

  const ArrivalCard({
    Key? key,
    required this.title,
    required this.deliveryTime,
    required this.pickupLocation,
    required this.onSeeItems,
    required this.onSlideComplete,
  }) : super(key: key);

  @override
  State<ArrivalCard> createState() => _ArrivalCardState();
}

class _ArrivalCardState extends State<ArrivalCard> {
  bool hasArrived = false; // Track if the button is tapped

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
                    widget.title,
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: widget.onSeeItems,
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
                "To be delivered by ${widget.deliveryTime}",
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
                        widget.pickupLocation,
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Conditional Arrival Button / Arrived Text
              hasArrived
                  ? Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Arrived",
                          style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          hasArrived = true; // Update state to show "Arrived"
                        });
                        widget.onSlideComplete(); // Call the function when tapped
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Tap after arrival at pickup",
                            style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                          ),
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

