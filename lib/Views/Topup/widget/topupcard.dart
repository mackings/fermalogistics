import 'package:flutter/material.dart';
import 'package:getnamibia/Views/widgets/texts.dart';

class TopUpCard extends StatelessWidget {
  final String balance;
  final VoidCallback onTopUp;

  const TopUpCard({
    Key? key,
    required this.balance,
    required this.onTopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9; // 90% of screen width
    double height = 97; // Keep the same height but responsive width

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // Bottom Layer (Most Faded)
            Positioned(
              left: width * 0.1,
              top: height * 0.25,
              child: _buildLayer(width * 0.8, height * 0.75, opacity: 0.3),
            ),
            // Middle Layer (Slightly More Visible)
            Positioned(
              left: width * 0.05,
              top: height * 0.13,
              child: _buildLayer(width * 0.9, height * 0.85, opacity: 0.6),
            ),
            // Top Layer (Main Card)
            _buildMainCard(width, height),
          ],
        ),
      ),
    );
  }

  // Function to build a background layer
  Widget _buildLayer(double width, double height, {required double opacity}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFFEA2A3A).withOpacity(opacity), // Red color with varying opacity
        borderRadius: BorderRadius.circular(19),
      ),
    );
  }

  // Function to build the main card (Top Layer)
  Widget _buildMainCard(double width, double height) {
    return Container(
      width: width,
      height: height * 0.9,
      decoration: BoxDecoration(
        color: Color(0xFFEA2A3A),
        borderRadius: BorderRadius.circular(19),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Balance Display
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Balance",
                color: Colors.white.withOpacity(0.8),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  CustomText(
                    text: balance,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    ),
                  // Text(
                  //   balance,
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(width: 8),
                  Icon(Icons.visibility_off, color: Colors.white, size: 18), // Eye icon
                ],
              ),
            ],
          ),

          // Top-Up Button or Logo Placeholder
          InkWell(
            onTap: onTopUp,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3), // Semi-transparent white
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "FAMA LOGISTICS", // Replace with your logo widget
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
