
import 'package:getnamibia/Views/Drivers/Deliveries/Api/apiservice.dart';
import 'package:getnamibia/Views/Drivers/Deliveries/Model/ordermodel.dart';
import 'package:getnamibia/Views/Drivers/Deliveries/widgets/Order.dart';
import 'package:getnamibia/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:getnamibia/Views/Drivers/Pickups/Views/details.dart';
import 'package:getnamibia/Views/Drivers/widgets/shippingcard.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';



class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;
  final DeliveryService _deliveryService = DeliveryService(); 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: "Deliveries", fontWeight: FontWeight.w500),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  tabs: [
                    CustomTab(title: 'Upcoming', isActive: _activeIndex == 0),
                    CustomTab(title: 'Completed', isActive: _activeIndex == 1),
                    CustomTab(title: 'Cancelled', isActive: _activeIndex == 2),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            DeliveriesList(status: "pending", deliveryService: _deliveryService),
            DeliveriesList(status: "Completed", deliveryService: _deliveryService),
            DeliveriesList(status: "Cancelled", deliveryService: _deliveryService),
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isActive;

  const CustomTab({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: isActive ? Colors.black : Colors.grey,
          fontSize: 10,
        ),
      ),
    );
  }
}




class DeliveriesList extends StatelessWidget {
  final String status;
  final DeliveryService deliveryService;

  const DeliveriesList({required this.status, required this.deliveryService, Key? key}) : super(key: key);

  Future<List<SendOrder>> _getOrders() {
    switch (status) {
      case "Completed":
        return deliveryService.fetchCompletedOrders();
      case "Cancelled":
        return deliveryService.fetchCancelledOrders();
      default:
        return deliveryService.fetchUpcomingOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SendOrder>>(
      future: _getOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.red,));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No $status deliveries yet.'));
        } else {
          List<SendOrder> deliveries = snapshot.data!;

          return ListView.builder(
            itemCount: deliveries.length,
            itemBuilder: (context, index) {
              SendOrder delivery = deliveries[index];

              // Format date and time
              String formattedDate = DateFormat('dd MMM yyyy').format(delivery.createdAt ?? DateTime.now());
              String formattedTime = DateFormat('h:mm a').format(delivery.createdAt ?? DateTime.now());

              // Determine pickup and drop-off locations
              String pickupLocation = delivery.pickupAddress ?? "Warehouse";
              String dropOffLocation = delivery.receiverAddress ?? delivery.shippingAddress ?? "N/A";

              // Determine product images (fallback to user icon if empty)
              List<String> productImages = delivery.cartItems?.map((item) => item.picture).where((img) => img != null && img.isNotEmpty).cast<String>().toList() ?? [];

              if (productImages.isEmpty) {
                productImages = ["https://cdn-icons-png.flaticon.com/512/149/149071.png"]; // User icon
              }

              // Always display "Pending" orders as "Upcoming"
              String displayStatus = (delivery.status == "Pending") ? "Upcoming" : delivery.status ?? "Unknown";

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showAcceptOrderSheet(
      context: context,
      title: "New Delivery Request",
      deliveryTime: formattedTime,
      pickupLocation: pickupLocation,
      onAccept: () {
        
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PickupDetailsPage(
        upcomingOrder: delivery,
      ),
    ),
  );

      },
      onDecline: () {

      },
      onSeeItems: () {

      },
    );
                  },
                  child: DeliveryCard(
                    pickupLocation: pickupLocation,
                    dropOffLocation: dropOffLocation,
                    recipientName: delivery.userId?.fullName ?? "Unknown",
                    recipientPhone: delivery.userId?.phoneNumber ?? "Unknown",
                    status: displayStatus,
                    date: formattedDate,
                    time: formattedTime,
                    productImages: productImages,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}



