import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';



class ShipmentOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ShipmentOptionCard(
                  color: Color(0xFFFFF2F3),
                  title: 'Send Package',
                  subtitle: 'Pickup or drop off orders',
                  img: Image.asset('assets/send.jpg')
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ShipmentOptionCard(
                  color: Color(0xFFE9E3FD),
                  title: 'Get a Quote',
                  subtitle: 'Know your shipment fee',
                  img: Image.asset('assets/quote.jpg')
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ShipmentOptionCard(
                  color: Color(0xFFE7F9DF),
                  title: 'Track Shipment',
                  subtitle: 'See where your order is',
                  img: Image.asset('assets/track.jpg')
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ShipmentOptionCard(
                  color: Color(0xFFFFEBC9),
                  title: 'Request Product',
                  subtitle: 'Enquire for any product',
                  img: Image.asset('assets/request.jpg')
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShipmentOptionCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final Widget img;

  ShipmentOptionCard({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.13),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: img
          ),

          const SizedBox(height: 9),

          CustomText(
            text:title,
            color: Color(0xFF121212),
            fontWeight: FontWeight.w600,
            fontSize: SizerExt(8).sp,
          ),


           CustomText(
            text:subtitle,
            color:Color(0xFF808080),
            fontSize: SizerExt(5.6).sp,

          ),
        ],
      ),
    );
  }
}



class ShipmentTrackingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.25,
          decoration: ShapeDecoration(
            color: Color(0xFFEA2A3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: screenWidth * 0.1,
                top: screenHeight * 0.07,
                child: Opacity(
                  opacity: 0.30,
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.2,
                    decoration: ShapeDecoration(
                      color: Color(0xFFEA2A3A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.04,
                child: Opacity(
                  opacity: 0.60,
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.21,
                    decoration: ShapeDecoration(
                      color: Color(0xFFEA2A3A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(text: 'Track your Shipment',
                       color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: screenHeight * 0.01),
                    Opacity(
                      opacity: 0.70,
                      child:  CustomText(text: 'Please enter your Tracking Number',
                       color: Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w400,
                    ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: Color(0xFFEE5D64),
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Tracking Number',
                                hintStyle: GoogleFonts.inter(color: Colors.white),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.08,
                            height: screenHeight * 0.04,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.01),
                              ),
                            ),
                            child: Icon(Icons.qr_code_scanner, color: Color(0xFFEE5D64)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


