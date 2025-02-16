
import 'package:fama/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:fama/Views/Drivers/Pickups/Views/details.dart';
import 'package:fama/Views/Drivers/Pickups/widgets/arrivecard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Arrival extends StatefulWidget {
  final SendOrder upcomingOrder; // Accept upcomingOrder as a parameter

  const Arrival({Key? key, required this.upcomingOrder}) : super(key: key);

  @override
  State<Arrival> createState() => _ArrivalState();
}

class _ArrivalState extends State<Arrival> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(text: "Arrival"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            ArrivalCard(
              title: "1 New Delivery",
              deliveryTime: widget.upcomingOrder.createdAt != null
    ? DateFormat('h:mm a').format(widget.upcomingOrder.createdAt!)
    : "N/A",

              pickupLocation: '${widget.upcomingOrder!.pickupAddress==null?
                            widget.upcomingOrder!.shippingAddress.toString():widget.upcomingOrder!.pickupAddress}',
              onSeeItems: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickupDetailsPage(
                      upcomingOrder: widget.upcomingOrder, // Pass the order to details page
                    ),
                  ),
                );
              },
              onSlideComplete: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickupDetailsPage(
                      upcomingOrder: widget.upcomingOrder, 
                    ),
                  ),
                );
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
