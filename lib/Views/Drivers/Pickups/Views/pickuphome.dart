import 'package:fama/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/arrival.dart';
import 'package:fama/Views/Drivers/Pickups/Views/details.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/pickcard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickupHome extends StatefulWidget {
  const PickupHome({super.key});

  @override
  State<PickupHome> createState() => _PickupHomeState();
}

class _PickupHomeState extends State<PickupHome> {
  PickupService pickupService = PickupService();
  SendOrder? upcomingOrder;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchUpcomingOrder();
  }

  Future<void> fetchUpcomingOrder() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(text: "Deliveries"),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No upcoming deliveries available",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  )
                : Column(
                    children: [
                      NewDeliveryCard(
                        title: "1 New Delivery",
deliveryTime: upcomingOrder?.createdAt != null
    ? DateFormat('h:mm a').format(upcomingOrder!.createdAt!)
    : "N/A",

                        pickupLocation: upcomingOrder!.shippingAddress.toString(),
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
                        onAccept: () {
                          if (upcomingOrder != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Arrival(
                                  upcomingOrder: upcomingOrder!,
                                ),
                              ),
                            );
                          }
                        },
                        onDecline: () {
                          print(upcomingOrder!.shippingAddress);
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
