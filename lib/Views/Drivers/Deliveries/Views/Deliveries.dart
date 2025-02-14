
import 'package:fama/Views/Drivers/Deliveries/Api/apiservice.dart';
import 'package:fama/Views/Drivers/Deliveries/Model/ordermodel.dart';
import 'package:fama/Views/Drivers/widgets/shippingcard.dart';
import 'package:fama/Views/widgets/texts.dart';
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
              margin: EdgeInsets.symmetric(horizontal: 16),
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
            DeliveriesList(status: "Upcoming", deliveryService: _deliveryService),
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
          fontSize: 12,
        ),
      ),
    );
  }
}




class DeliveriesList extends StatelessWidget {
  final String status;
  final DeliveryService deliveryService;

  const DeliveriesList({required this.status, required this.deliveryService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SendOrder>>(
      future: deliveryService.fetchDeliveries(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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
              String formattedDate = DateFormat('dd MMM yyyy').format(delivery.createdAt);
              String formattedTime = DateFormat('h:mm a').format(delivery.createdAt);

              // Get product images
              List<String> productImages = delivery.cartItems.map((item) => item.picture).toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DeliveryCard(
                  pickupLocation: delivery.shippingAddress,
                  dropOffLocation: delivery.shippingAddress,
                  recipientName: delivery.userId.fullName,
                  recipientPhone: delivery.userId.phoneNumber.toString(),
                  status: delivery.status,
                  date: formattedDate,
                  time: formattedTime,
                  productImages: productImages, // Pass product images
                ),
              );
            },
          );
        }
      },
    );
  }
}


