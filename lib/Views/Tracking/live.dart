import 'package:fama/Views/Tracking/widgets/thetimeline.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:sizer/sizer.dart';

class LiveTracking extends StatefulWidget {
  const LiveTracking({Key? key}) : super(key: key);

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kLagos = CameraPosition(
    target: LatLng(6.5244, 3.3792),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title: CustomText(text: "Tracking Details")),
  body: Stack(
    children: [
      GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kLagos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 65.h),
              LocationWithDottedLine(),
              Container(
                decoration: BoxDecoration(
                    color: btngrey, borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: CustomText(
                      text: "Mac Kingsley",
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle: CustomText(
                      text: "Customer Services",
                      color: Colors.grey,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: btngrey, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTimelineTile(
                        title: "Request Placed",
                        subtitle: "We have received your request",
                        date: "7th Dec 2024",
                        time: "18:00",
                        isFirst: true,
                      ),
                      CustomTimelineTile(
                        title: "Request Processed",
                        subtitle: "We will soon give you feedback",
                        date: "7th Dec 2024",
                        time: "18:00",
                      ),
                      CustomTimelineTile(
                        title: "Request Delivered",
                        subtitle: "Check your notification",
                        date: "7th Dec 2024",
                        time: "18:00",
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5.h,),
            ],
          ),
        ),
      ),
    ],
  ),

);

  }


}




class LocationWithDottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: CustomPaint(
        size: Size(double.infinity, 100), // Adjust height based on the distance between locations
        painter: DottedLinePainter(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationCircle(name: 'Ibadan'),
            SizedBox(height: 50), // Space between locations, adjust as needed
            LocationCircle(name: 'Lagos'),
          ],
        ),
      ),
    );
  }
}

class LocationCircle extends StatelessWidget {
  final String name;

  LocationCircle({required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              name[0],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(name),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    // Draw a dotted line
    const dotSize = 4.0;
    const dotSpacing = 8.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawCircle(Offset(x, size.height / 2), dotSize / 2, paint);
      x += dotSize + dotSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}