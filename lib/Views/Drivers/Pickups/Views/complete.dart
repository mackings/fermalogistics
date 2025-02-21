
import 'package:fama/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/success.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/deliverycard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';






class CompleteDelivery extends StatefulWidget {
  final SendOrder upcomingOrder;

  const CompleteDelivery({Key? key, required this.upcomingOrder}) : super(key: key);

  @override
  State<CompleteDelivery> createState() => _CompleteDeliveryState();
}

class _CompleteDeliveryState extends State<CompleteDelivery> {


  bool isLoading = false;
  bool isCompletingDelivery = false;
  
  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng? pickupLocation;
  LatLng? dropoffLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

  Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showBottomSheet = true;
        });
      }
    });
  }

  /// Fetch user's current location (delivery agent)
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    
    setState(() {
      _currentPosition = position;
    });

    await _getLocations(); // Fetch pickup & drop-off coordinates
  }

  /// Fetch coordinates for pickup and drop-off locations
  Future<void> _getLocations() async {
    LatLng updatedPickupLocation = LatLng(6.5244, 3.3792); // Default Lagos
    LatLng? updatedDropoffLocation;

    try {
      // Determine pickup location
      if (widget.upcomingOrder.pickupAddress != null &&
          widget.upcomingOrder.pickupAddress!.isNotEmpty) {
        if (widget.upcomingOrder.pickupAddress!.toLowerCase() == "warehouse") {
          List<geo.Location> locations = await geo.locationFromAddress("Lagos, Nigeria");
          if (locations.isNotEmpty) {
            updatedPickupLocation = LatLng(locations.first.latitude, locations.first.longitude);
          }
        } else {
          List<geo.Location> locations = await geo.locationFromAddress(widget.upcomingOrder.pickupAddress!);
          if (locations.isNotEmpty) {
            updatedPickupLocation = LatLng(locations.first.latitude, locations.first.longitude);
          }
        }
      }

      // Determine drop-off location
      if (widget.upcomingOrder.shippingAddress != null &&
          widget.upcomingOrder.shippingAddress!.isNotEmpty) {
        List<geo.Location> locations = await geo.locationFromAddress(widget.upcomingOrder.shippingAddress!);
        if (locations.isNotEmpty) {
          updatedDropoffLocation = LatLng(locations.first.latitude, locations.first.longitude);
        }
      }

      // Update state
      setState(() {
        pickupLocation = updatedPickupLocation;
        dropoffLocation = updatedDropoffLocation;
        _updateMarkers();
        _updatePolyline();
      });

      _fitCameraBounds();
    } catch (e) {
      print("Error fetching coordinates: $e");
    }
  }

  /// Add markers for pickup, drop-off, and user location
  void _updateMarkers() {
    _markers.clear();

    if (pickupLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("pickup"),
          position: pickupLocation!,
          infoWindow: const InfoWindow(title: "Pickup Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    if (dropoffLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("dropoff"),
          position: dropoffLocation!,
          infoWindow: const InfoWindow(title: "Drop-off Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId("current"),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(title: "Your Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  /// Draw a polyline between pickup and drop-off
  void _updatePolyline() {
    _polylines.clear();

    if (pickupLocation != null && dropoffLocation != null) {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.red,
          width: 5,
          points: [pickupLocation!, dropoffLocation!],
          geodesic: true,
        ),
      );
    }
  }

  /// Ensure the camera fits all markers
  void _fitCameraBounds() {
    if (pickupLocation == null || dropoffLocation == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(pickupLocation!.latitude, dropoffLocation!.latitude),
        min(pickupLocation!.longitude, dropoffLocation!.longitude),
      ),
      northeast: LatLng(
        max(pickupLocation!.latitude, dropoffLocation!.latitude),
        max(pickupLocation!.longitude, dropoffLocation!.longitude),
      ),
    );

    _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

    Future<void> _handleDeliveryCompletion(BuildContext context) async {
    setState(() {
      isCompletingDelivery = true;
    });

    PickupService pickupService = PickupService();
    Map<String, dynamic> response = await pickupService
        .markDeliveryCompleted(widget.upcomingOrder.id.toString());

    if (mounted) {
      setState(() {
        isCompletingDelivery = false; // Hide loading indicator
      });

      if (response['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('ongoing_order');

        showDeliveryCompletedSheet(context); // Show completion dialog
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


bool isArrivalSuccessful = false; // Track API success

Future<void> _handleDeliveryArrival(BuildContext context) async {
  setState(() {
    isLoading = true;
  });

  PickupService pickupService = PickupService();
  Map<String, dynamic> response =
      await pickupService.markDeliveryArrived(widget.upcomingOrder.id.toString());

  if (mounted) {
    setState(() {
      isLoading = false;
      if (response['success']) {
        isArrivalSuccessful = true; // ✅ Mark arrival as successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Customer is now Notified'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        isArrivalSuccessful = false; // ❌ Keep false if failed
        print(response['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}


  bool _showBottomSheet = false;



@override
Widget build(BuildContext context) {
  String deliveryDate =
      "${widget.upcomingOrder.createdAt!.day} ${_getMonth(widget.upcomingOrder.createdAt!.month)}, ${widget.upcomingOrder.createdAt!.year}";

  String deliveryTime =
      _formatTime(widget.upcomingOrder.createdAt ?? DateTime.now());
  String customerName = widget.upcomingOrder.userId!.fullName.toString();
  String? customerPhone = widget.upcomingOrder.userId!.phoneNumber;
  String? dropoffLocation = widget.upcomingOrder.shippingAddress;
  String? pickupLocation = widget.upcomingOrder.pickupAddress;
  String? deliveryLocation = widget.upcomingOrder.receiverAddress;

  return Scaffold(
      appBar: AppBar(title: CustomText(text: "Confirm delivery")),
      body: Stack(
        children: [
          /// 🗺 Google Map as Background
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(6.5244, 3.3792), // Default: Lagos, Nigeria
                zoom: 14,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                _mapController = controller;
                _fitCameraBounds();
              },
            ),
          ),

          /// 📦 Delayed Draggable Bottom Sheet for Delivery Info
          if (_showBottomSheet) // 👈 Only show bottom sheet after delay
            DraggableScrollableSheet(
              initialChildSize: 0.15, // Starts small
              minChildSize: 0.15, // Minimum size
              maxChildSize: 0.6, // Expandable size
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        /// Small Drag Handle
                        Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 10),

                        DeliveryInfoCard(
                          deliveryTime: deliveryTime ?? "N/A",
                          deliveryDate: deliveryDate ?? "N/A",
                          customerName: customerName ?? "Unknown",
                          customerPhone: customerPhone?.toString() ?? "No phone",
                          pickupLocation: pickupLocation ?? "Warehouse",
                          dropoffLocation: deliveryLocation ?? widget.upcomingOrder.shippingAddress,
                          status: widget.upcomingOrder.status?.toString() ?? "Pending",
                          profileImageUrl: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                          buttonColor: Colors.red,
                          buttonText: "Arrived at Customer Location",
                          onStatusButtonTap: () async {
                            await _handleDeliveryArrival(context);
                          },
                        ),

                        const SizedBox(height: 10),

if (isArrivalSuccessful)
  isCompletingDelivery
      ? const CircularProgressIndicator()
      : Padding(
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: CustomButton(
            text: "Deliver Product",
            onPressed: () async {
              await _handleDeliveryCompletion(context);
            },
          ),
        ),

                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
}

}

  String _getMonth(int month) {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return "N/A"; // Return a placeholder if null
    return DateFormat('hh:mm a').format(dateTime);
  }

