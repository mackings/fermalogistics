import 'dart:convert';

import 'package:fama/Views/Auth/attachimg.dart';
import 'package:fama/Views/Drivers/DriverHome.dart';
import 'package:fama/Views/Profile/Views/Profilehome.dart';
import 'package:fama/Views/Shipments/Api/shipmentservice.dart';
import 'package:fama/Views/Shipments/Model/shipmentmodel.dart';
import 'package:fama/Views/Shipments/widgets/shippingData.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/homecard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:intl/intl.dart';
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
  Shipment? latestShipment;

  //Location

  String? currentAddress;
  loc.LocationData? currentLocation;

  Future<void> getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return; // Location services are not enabled
      }
    }

    // Check for location permissions
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return; // Location permission denied
      }
    }

    // Get the current location
    currentLocation = await location.getLocation();

    // Use the geocoding package to get placemarks
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    );

    // Check if placemarks are available
    if (placemarks.isNotEmpty) {
      geocoding.Placemark place = placemarks[0];
      setState(() {
        // Construct a detailed address
        currentAddress =
            "${place.name}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    }
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

  Future<void> fetchLatestShipment() async {
    try {
      List<dynamic> shipments = await ShipmentService().fetchShipments();
      if (shipments.isNotEmpty) {
        setState(() {
          // Convert the first item in shipments list to a Shipment object
          latestShipment = Shipment.fromJson(shipments.first);
        });
      }
    } catch (e) {
      print("Error fetching shipments: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _retrieveUserData();
    fetchLatestShipment();
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
                  // User Image or Icon in CircleAvatar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AttachImg()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      child: userImage != null &&
                              userImage.isNotEmpty &&
                              Uri.tryParse(userImage)?.hasAbsolutePath == true
                          ? ClipOval(
                              child: Image.network(
                                userImage,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 24,
                              color: Colors.grey,
                            ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Current Location',
                          fontSize: 7.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            //Icon(Icons.location_on, size: 18.sp),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Center(
                                child: CustomText(
                                  text: currentAddress ?? 'Updating Loc..',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down_outlined, size: 18.sp),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Notification Icon Container
                  GestureDetector(
                    onTap: () {

                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DriverHome()),
                      );

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ProfileHome()),
                      // );
                    },
                    child: Container(
                      height: 6.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                        color: btngrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.notifications_outlined, size: 20.sp),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 3.h,
              ),

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

              if (latestShipment != null) _buildShipmentCard(latestShipment!),

              // SearchCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShipmentCard(Shipment shipment) {
    String formatDate(String dateString) {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('d MMM yyyy').format(dateTime);
    }

    String shortenLocation(String location, {int maxLength = 15}) {
      return location.length > maxLength
          ? '${location.substring(0, maxLength)}...'
          : location;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ShippingCards(
        trackingID: shipment.trackingNumber,
        status: shipment.status,
        fromLocation: shortenLocation(shipment.pickupAddress),
        toLocation: shortenLocation(shipment.receiverAddress),
        fromDate: formatDate(shipment.createdAt.toString()),
        estimatedDate: formatDate(shipment.updatedAt.toString()),
        sender: shipment.senderName,
        weight: shipment.weightOfPackage.toString(),
        timelineData: [],
      ),
    );
  }
}
