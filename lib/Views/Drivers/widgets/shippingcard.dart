import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryCard extends StatelessWidget {
  final String pickupLocation;
  final String dropOffLocation;
  final String recipientName;
  final String recipientPhone;
  final String status;
  final String date;
  final String time;
  final String profileImageUrl;

  const DeliveryCard({
    Key? key,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.recipientName,
    required this.recipientPhone,
    required this.status,
    required this.date,
    required this.time,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pick up and Drop off Locations
          Row(
            children: [
              Column(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  Container(height: 20, width: 2, color: Colors.grey),
                  Icon(Icons.local_shipping, color: Colors.black),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Picked up from",
                        style: GoogleFonts.inter(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(pickupLocation,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 8),
                    Text("Drop off",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(dropOffLocation,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Divider(height: 20, thickness: 1),

          // Recipient Details
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl),
                radius: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipientName,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Text(recipientPhone,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        )),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(time,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(date,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


