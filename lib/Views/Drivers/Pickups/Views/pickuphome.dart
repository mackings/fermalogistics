import 'dart:convert';
import 'package:fama/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/arrival.dart';
import 'package:fama/Views/Drivers/Pickups/Views/details.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/pickcard.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';




class PickupHome extends StatefulWidget {
  const PickupHome({super.key});

  @override
  State<PickupHome> createState() => _PickupHomeState();
}

class _PickupHomeState extends State<PickupHome> {
  PickupService pickupService = PickupService();
  SendOrder? upcomingOrder;
  SendOrder? ongoingOrder; // Store the ongoing order from SharedPreferences
  bool isLoading = true;
  bool hasError = false;
  bool acceptingOrder = false; // Track order acceptance

  @override
  void initState() {
    super.initState();
    checkOngoingOrder();
    fetchUpcomingOrder();
  }

  Future<void> checkOngoingOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? orderJson = prefs.getString('ongoing_order');
    if (orderJson != null) {
      setState(() {
        ongoingOrder = SendOrder.fromMap(jsonDecode(orderJson));
      });

      // Show bottom modal if an ongoing order exists
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

    // Check if an ongoing order exists
    if (ongoingOrder != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("You already have an ongoing order. Complete it first."),
          backgroundColor: Colors.orange,
        ),
      );

      showOngoingOrderModal();
      return;
    }

    setState(() {
      acceptingOrder = true;
    });

    bool success = await pickupService.acceptOrder(upcomingOrder!.id!);

    setState(() {
      acceptingOrder = false;
    });

    if (success) {
      // Save the accepted order to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'ongoing_order', jsonEncode(upcomingOrder!.toMap()));

      setState(() {
        ongoingOrder = upcomingOrder;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Arrival(
            upcomingOrder: upcomingOrder!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to accept order. Try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show the bottom modal sheet for the ongoing order


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
                deliveryTime: ongoingOrder?.createdAt != null
                    ? DateFormat('h:mm a').format(ongoingOrder!.createdAt!)
                    : "N/A",
                pickupLocation: "${ongoingOrder!.pickupAddress == null?ongoingOrder!.shippingAddress.toString():ongoingOrder!.pickupAddress}",
                onSeeItems: () {
                 print(ongoingOrder!.pickupAddress);

                  if (ongoingOrder != null) {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickupDetailsPage(
                          upcomingOrder: ongoingOrder!,
                        ),
                      ),
                    );
                  }
                },
                onAccept: () {},
                onDecline: () {},
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    text: 'Complete Delivery',
                    onPressed: () async {
                      if (ongoingOrder != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PickupDetailsPage(
                              upcomingOrder: ongoingOrder!,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        );
      },
    );
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
      child: CustomText(text: "Deliveries")),
  ),
  body: Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          'assets/mapbg.png', 
          fit: BoxFit.cover,
        ),
      ),
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

                      SizedBox(height: 43.h,),

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
