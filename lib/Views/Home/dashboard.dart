import 'dart:convert';

import 'package:fama/Views/Auth/attachimg.dart';
import 'package:fama/Views/Tracking/widgets/searchcard.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/homecard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:fama/Views/widgets/tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  dynamic userToken;
  dynamic userImage;

  //Location

  String? currentAddress;
  loc.LocationData? currentLocation;

  Future<void> getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();

    // Convert the coordinates to an address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );

    Placemark place = placemarks[0];
    setState(() {
      currentAddress = "${place.locality}, ${place.country}";
    });
  }

  Future<void> _retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);

      String? token = userData['token'];
      Map<String, dynamic> user = userData['user'];

      String? fullName = user['fullName'];
      String? email = user['email'];

      setState(() {
        userToken = userData['token'];
        userImage = user['picture'];
        print(userToken);
        print(userImage);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AttachImg()));
                        },
                        child: Icon(Icons.person)),
                  ),
                  Column(
                    children: [
                      CustomText(
                          text: 'Current Location',
                          fontSize: 7.sp,
                          color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.location_on),
                          CustomText(
                            text: currentAddress ?? 'Updating Loc..',
                            fontWeight: FontWeight.w600,
                          ),
                          Icon(Icons.arrow_drop_down_outlined)
                        ],
                      )
                    ],
                  ),
                  Container(
                      height: 6.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                          color: btngrey,
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.notifications_outlined))
                ],
              ),

              SizedBox(
                height: 3.h,
              ),

              // Other widgets here...

              ShipmentTrackingCard(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomText(
                      text: 'Our Services',
                      fontWeight: FontWeight.w700,
                    )
                  ],
                ),
              ),

              ShipmentOptions(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Recent Shipping',
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: 'See all',
                      color: Colors.grey,
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 1.h,
              ),

              SearchCard(),
            ],
          ),
        ),
      ),
    );
  }
}
