import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/deliverycard.dart';
import 'package:flutter/material.dart';

class Pickupdelivery extends StatefulWidget {
  final SendOrder upcomingOrder; // Accept SendOrder object

  const Pickupdelivery({
    Key? key,
    required this.upcomingOrder,
  }) : super(key: key);

  @override
  State<Pickupdelivery> createState() => _PickupdeliveryState();
}

class _PickupdeliveryState extends State<Pickupdelivery> {
  @override
  Widget build(BuildContext context) {

    String _formatTime(DateTime dateTime) {
  int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour == 0 ? 12 : dateTime.hour;
  String minute = dateTime.minute.toString().padLeft(2, '0');
  String period = dateTime.hour >= 12 ? "PM" : "AM";

  return "$hour:$minute$period";
}
    // Extract necessary data
    String deliveryDate =
        "${widget.upcomingOrder.createdAt.day} ${_getMonth(widget.upcomingOrder.createdAt.month)}, ${widget.upcomingOrder.createdAt.year}";

    String deliveryTime = _formatTime(widget.upcomingOrder.createdAt);

    String customerName = widget.upcomingOrder.userId.fullName;
    String customerPhone = widget.upcomingOrder.userId.phoneNumber;
    String dropoffLocation = widget.upcomingOrder.shippingAddress;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),

          DeliveryInfoCard(
            deliveryTime: deliveryTime,
            deliveryDate: deliveryDate,
            customerName: customerName,
            customerPhone: customerPhone,
            pickupLocation: "Warehouse", // Assuming pickup location is warehouse
            dropoffLocation: dropoffLocation,
            status: widget.upcomingOrder.status, // Use actual status
            profileImageUrl: "https://via.placeholder.com/150", // Replace with actual image
          ),
        ],
      ),
    );
  }

  // Helper function to get month name
  String _getMonth(int month) {
    List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}
