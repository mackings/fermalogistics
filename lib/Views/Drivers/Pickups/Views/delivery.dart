import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/complete.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/deliverycard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';



class Pickupdelivery extends StatefulWidget {
  final SendOrder upcomingOrder;

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
      int hour = dateTime.hour > 12
          ? dateTime.hour - 12
          : dateTime.hour == 0
              ? 12
              : dateTime.hour;
      String minute = dateTime.minute.toString().padLeft(2, '0');
      String period = dateTime.hour >= 12 ? "PM" : "AM";

      return "$hour:$minute$period";
    }

    String deliveryDate =
        "${widget.upcomingOrder.createdAt!.day} ${_getMonth(widget.upcomingOrder.createdAt!.month)}, ${widget.upcomingOrder.createdAt!.year}";

    String deliveryTime =
        _formatTime(widget.upcomingOrder.createdAt ?? DateTime.now());

    String customerName = widget.upcomingOrder.userId!.fullName.toString();
    String customerPhone = widget.upcomingOrder.userId!.phoneNumber.toString();
    String? dropoffLocation = widget.upcomingOrder.shippingAddress;
    String? pickupLocation = widget.upcomingOrder.pickupAddress;
    String? deliveryLocation = widget.upcomingOrder.receiverAddress;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Pickup Status"),
      ),
      body: Column(
        children: [
          DeliveryInfoCard(
            deliveryTime: deliveryTime,
            deliveryDate: deliveryDate,
            customerName: customerName,
            customerPhone: customerPhone,
            pickupLocation: pickupLocation == null?"WareHouse":pickupLocation,
            dropoffLocation: deliveryLocation== null? dropoffLocation.toString():deliveryLocation,
            status: widget.upcomingOrder.status.toString(),
            profileImageUrl: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
            onStatusButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CompleteDelivery(upcomingOrder: widget.upcomingOrder),
                ),
              );
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
