import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/success.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/deliverycard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompleteDelivery extends StatefulWidget {
  final SendOrder upcomingOrder;

  const CompleteDelivery({
    Key? key,
    required this.upcomingOrder,
  }) : super(key: key);

  @override
  State<CompleteDelivery> createState() => _CompleteDeliveryState();
}

class _CompleteDeliveryState extends State<CompleteDelivery> {

  String _formatTime(DateTime? dateTime) {
  if (dateTime == null) return "N/A"; // Return a placeholder if null
  return DateFormat('hh:mm a').format(dateTime);
}

  @override
  Widget build(BuildContext context) {
    String _formatTime(DateTime dateTime) {
      int hour = dateTime.hour > 12
          ? dateTime.hour - 12
          : dateTime.hour == 0
              ? 12
              : dateTime.hour;
      String minute = dateTime.minute.toString().padLeft(2, '0');
      String period = dateTime.hour >= 12 ? "PM" : "AM";

      return "$hour:$minute$period";
    }

    // Extract necessary data
    String deliveryDate =
        "${widget.upcomingOrder.createdAt!.day} ${_getMonth(widget.upcomingOrder.createdAt!.month)}, ${widget.upcomingOrder.createdAt!.year}";

    String deliveryTime = _formatTime(widget.upcomingOrder.createdAt ?? DateTime.now());


    String customerName = widget.upcomingOrder.userId!.fullName.toString();
    String? customerPhone = widget.upcomingOrder.userId!.phoneNumber;
    String? dropoffLocation = widget.upcomingOrder.shippingAddress;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Confirm delivery"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          DeliveryInfoCard(
            deliveryTime: deliveryTime,
            deliveryDate: deliveryDate,
            customerName: customerName,
            customerPhone: customerPhone.toString(),
            pickupLocation: "Warehouse",
            dropoffLocation: dropoffLocation.toString(),
            status: widget.upcomingOrder.status.toString(), // Use actual status
            profileImageUrl: "https://via.placeholder.com/150",
            buttonColor: Colors.red,
            buttonText: "Arrived at Customer location",
            onStatusButtonTap: () {
              showDeliveryCompletedSheet(context);
            },
          ),
        ],
      ),
    );
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
}
