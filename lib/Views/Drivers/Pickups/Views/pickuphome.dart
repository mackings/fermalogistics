import 'dart:convert';
import 'package:fama/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/arrival.dart';
import 'package:fama/Views/Drivers/Pickups/Views/details.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/pickcard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';




class PickupHome extends StatefulWidget {
  const PickupHome({super.key});

  @override
  State<PickupHome> createState() => _PickupHomeState();
}

class _PickupHomeState extends State<PickupHome> {

  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng? pickupLocation;
  PickupService pickupService = PickupService();
  SendOrder? upcomingOrder;
  SendOrder? ongoingOrder;
  bool isLoading = true;
  bool hasError = false;
  bool acceptingOrder = false;

  @override
  void initState() {
    super.initState();
    checkOngoingOrder();
    fetchUpcomingOrder();
    _getCurrentLocation();
  }


Future<void> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) return;
  }

  Position position = await Geolocator.getCurrentPosition();

  // Handle the case where latitude and longitude are not in the model
  LatLng updatedPickupLocation = LatLng(position.latitude, position.longitude); // Default to current location

  if (upcomingOrder != null && upcomingOrder!.pickupAddress != null && upcomingOrder!.pickupAddress!.isNotEmpty) {
    try {
      List<geo.Location> locations = await geo.locationFromAddress(upcomingOrder!.pickupAddress!);
      if (locations.isNotEmpty) {
        updatedPickupLocation = LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print("Error getting coordinates from address: $e");
    }
  }

  setState(() {
    _currentPosition = position;
    pickupLocation = updatedPickupLocation;
  });

  _mapController?.animateCamera(CameraUpdate.newLatLng(updatedPickupLocation));
}



  Future<void> checkOngoingOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? orderJson = prefs.getString('ongoing_order');
    if (orderJson != null) {
      setState(() {
        ongoingOrder = SendOrder.fromMap(jsonDecode(orderJson));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOngoingOrderModal();
      });
    }
  }

  Future<void> fetchUpcomingOrder() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      PickupModel? pickupData = await pickupService.fetchPickupOrders();
      if (pickupData != null && pickupData.sendOrders!.isNotEmpty) {
        setState(() {
          upcomingOrder = pickupData.sendOrders!.first;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  Future<void> onAcceptOrder() async {
    if (upcomingOrder == null) return;
    if (ongoingOrder != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You already have an ongoing order. Complete it first."),
          backgroundColor: Colors.orange,
        ),
      );
      showOngoingOrderModal();
      return;
    }
    setState(() => acceptingOrder = true);
    bool success = await pickupService.acceptOrder(upcomingOrder!.id!);
    setState(() => acceptingOrder = false);
    if (success) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('ongoing_order', jsonEncode(upcomingOrder!.toMap()));
      setState(() => ongoingOrder = upcomingOrder);
      Navigator.push(context, MaterialPageRoute(builder: (context) => PickupDetailsPage(upcomingOrder: upcomingOrder!)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to accept order. Try again."), backgroundColor: Colors.red),
      );
    }
  }

  void showOngoingOrderModal() {
    if (ongoingOrder == null) return;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NewDeliveryCard(
                title: "Ongoing Delivery",
                deliveryTime: ongoingOrder?.createdAt != null ? DateFormat('h:mm a').format(ongoingOrder!.createdAt!) : "N/A",
                pickupLocation: ongoingOrder!.pickupAddress ?? ongoingOrder!.shippingAddress.toString(),
                onSeeItems: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PickupDetailsPage(upcomingOrder: ongoingOrder!)),
                  );
                },
                onAccept: () {},
                onDecline: () {},
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Complete Delivery',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PickupDetailsPage(upcomingOrder: ongoingOrder!)),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Set<Polyline> _polylines = {}; // Store the polyline

void _updatePolyline() {
  if (_currentPosition == null || pickupLocation == null) return;

  _polylines.clear(); // Clear existing polylines before updating

  _polylines.add(
    Polyline(
      polylineId: PolylineId("route"),
      color: Colors.red, // Thick red line
      width: 5, // Thickness of the line
      points: [
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude), // Start (current location)
        pickupLocation!, // Destination (pickup location)
      ],
      geodesic: true, // Makes the polyline follow Earth's curvature
    ),
  );

  setState(() {}); // Update UI
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _updatePolyline(); // Update polyline when dependencies change
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('ongoing_order');
      },
      child: CustomText(text: "Deliveries"),
    ),
  ),
  body: Stack(
    children: [
      /// 1️⃣ Map Background (Google Map)
      Positioned.fill(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition != null
                ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                : LatLng(0, 0),
            zoom: 15,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) => _mapController = controller,
          markers: pickupLocation != null
              ? {
                  Marker(
                    markerId: MarkerId("pickup"),
                    position: pickupLocation!,
                    infoWindow: InfoWindow(title: "Pickup Location"),
                  ),
                  Marker(
                    markerId: MarkerId("current"),
                    position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    infoWindow: InfoWindow(title: "Your Location"),
                  ),
                }
              : {},
          polylines: _polylines, // Thick red polyline
        ),
      ),

      /// 2️⃣ Semi-transparent Map Overlay (Optional, for better visibility)
      Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.2), // Makes UI elements stand out
        ),
      ),

      /// 3️⃣ UI Elements (Modals, Loading, Error Messages, NewDeliveryCard)
      Center(
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.red),
              )
            : hasError
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "No upcoming deliveries available",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: 43.h),

                      /// 🛑 Make Sure This is Above the Map
                      NewDeliveryCard(
                        title: "1 New Delivery",
                        deliveryTime: upcomingOrder?.createdAt != null
                            ? DateFormat('h:mm a')
                                .format(upcomingOrder!.createdAt!)
                            : "N/A",
                        pickupLocation:
                            '${upcomingOrder!.pickupAddress == null ? upcomingOrder!.shippingAddress.toString() : upcomingOrder!.pickupAddress}',
                        onSeeItems: () {
                          if (upcomingOrder != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PickupDetailsPage(
                                  upcomingOrder: upcomingOrder!,
                                ),
                              ),
                            );
                          }
                        },
                        onAccept:
                            acceptingOrder ? () {} : () => onAcceptOrder(),
                        onDecline: () {
                          print(upcomingOrder!.shippingAddress);
                        },
                      ),

                      if (acceptingOrder)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
      ),
    ],
  ),
);

  }
}