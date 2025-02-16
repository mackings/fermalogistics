import 'package:fama/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/success.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/deliverycard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';




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
  bool isLoading = false; // Track API call status
  bool isCompletingDelivery = false; // Track delivery completion status

  Future<void> _handleDeliveryArrival(BuildContext context) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    PickupService pickupService = PickupService();
    Map<String, dynamic> response = await pickupService
        .markDeliveryArrived(widget.upcomingOrder.id.toString());

    if (mounted) {
      setState(() {
        isLoading = false; // Hide loading indicator
      });

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Customer is now Notified'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print(response['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
  appBar: AppBar(
    title: CustomText(text: "Confirm delivery"),
  ),
  body: Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          'assets/mapbg.png', // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      Center(
        child: isLoading
            ? const CircularProgressIndicator() // Show loading spinner while API call is in progress
            : Column(
                children: [

                  SizedBox(height: 30.h),
                  
                  DeliveryInfoCard(
                    deliveryTime: deliveryTime,
                    deliveryDate: deliveryDate,
                    customerName: customerName,
                    customerPhone: customerPhone.toString(),
                    pickupLocation:
                        pickupLocation == null ? "Warehouse" : pickupLocation,
                    dropoffLocation: deliveryLocation == null
                        ? dropoffLocation.toString()
                        : deliveryLocation,
                    status: widget.upcomingOrder.status.toString(),
                    profileImageUrl:
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                    buttonColor: Colors.red,
                    buttonText: "Arrived at Customer location",
                    onStatusButtonTap: () async {
                      await _handleDeliveryArrival(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: isCompletingDelivery
                        ? const CircularProgressIndicator() // Show loading spinner when delivery is being completed
                        : CustomButton(
                            text: "Deliver Product",
                            onPressed: () async {
                              await _handleDeliveryCompletion(context);
                            },
                          ),
                  )
                ],
              ),
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

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return "N/A"; // Return a placeholder if null
    return DateFormat('hh:mm a').format(dateTime);
  }
}
