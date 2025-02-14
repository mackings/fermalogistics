import 'package:fama/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/details.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/deliverycard.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/pickcard.dart';
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
      if (pickupData != null && pickupData.sendOrders.isNotEmpty) {
        setState(() {
          upcomingOrder = pickupData.sendOrders.first; // Take first order
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true; // No orders available
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true; // Error occurred
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : hasError
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
                      const SizedBox(height: 10),
                      const Text("No upcoming deliveries available",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      NewDeliveryCard(
                        title: "1 New Delivery",
                        deliveryTime: DateFormat('h:mm a').format(upcomingOrder!.createdAt),
                        pickupLocation: upcomingOrder!.shippingAddress,
                        onSeeItems: () {
  if (upcomingOrder != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickupDetailsPage(
          upcomingOrder: upcomingOrder!, // Pass the entire order object
        ),
      ),
    );
  }
},

                        // onSeeItems: () {
                        //   if (upcomingOrder!.cartItems.isNotEmpty) {
                        //     CartItem firstItem = upcomingOrder!.cartItems.first;

                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => PickupDetailsPage(
                        //           customerName: upcomingOrder!.userId.fullName,
                        //           customerPhone: upcomingOrder!.userId.phoneNumber,
                        //           orderNumber: upcomingOrder!.orderId,
                        //           productName: firstItem.productName,
                        //           productImage: firstItem.picture,
                        //           productPrice: firstItem.price,
                        //           productQuantity: firstItem.quantity,
                        //         ),
                        //       ),
                        //     );
                        //   }
                        // },
                         onAccept: () {  }, 
                         onDecline: () {  },
                      ),


                    ],
                  ),
      ),
    );
  }
}

