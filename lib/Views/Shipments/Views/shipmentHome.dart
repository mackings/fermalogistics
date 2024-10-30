import 'package:fama/Views/Product/request.dart';
import 'package:fama/Views/Shipments/Api/shipmentservice.dart';
import 'package:fama/Views/Shipments/Model/shipmentmodel.dart';
import 'package:fama/Views/Shipments/widgets/shippingData.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ShipmentsHome extends ConsumerStatefulWidget {
  const ShipmentsHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShipmentsHomeState();
}

class _ShipmentsHomeState extends ConsumerState<ShipmentsHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;
  List<Shipment> allShipments = [];
  bool isLoading = true;
  final ShipmentService shipmentService =
      ShipmentService(); 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchShipments();
  }

  Future<void> _fetchShipments() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<dynamic> shipmentsData = await shipmentService.fetchShipments();
      setState(() {
        allShipments = Shipment.fromJsonList(shipmentsData);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching shipments: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Shipping'),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = constraints.maxWidth > 600
                    ? constraints.maxWidth * 0.8
                    : constraints.maxWidth - 32;

                return Center(
                  child: Container(
                    width: containerWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          CustomTab(
                            title: 'All',
                            isActive: _activeIndex == 0,
                          ),
                          CustomTab(
                            title: 'Active',
                            isActive: _activeIndex == 1,
                          ),
                          CustomTab(
                            title: 'Delivered',
                            isActive: _activeIndex == 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: _tabController != null
            ? TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1 - All Shipments
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : allShipments.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SvgPicture.asset(
                                  'assets/empty.svg',
                                  width: 300,
                                  height: 300,
                                ),
                                const SizedBox(height: 16.0),
                                CustomText(
                                  text: "No Shipments Available",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                                CustomText(
                                  text: "You haven't sent a product yet",
                                  fontSize: 8.sp,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: allShipments.length,
                              itemBuilder: (context, index) {
                                var shipment = allShipments[index];
                                return _buildShipmentCard(shipment);
                              },
                            ),

                  // Tab 2 - Active Shipments (Pending)
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : allShipments
                              .where((shipment) => shipment.status == 'pending')
                              .isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SvgPicture.asset(
                                  'assets/empty.svg',
                                  width: 300,
                                  height: 300,
                                ),
                                const SizedBox(height: 16.0),
                                CustomText(
                                  text: "No Active Shipments Yet",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "You haven't sent a product yet",
                                    fontSize: 8.sp,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: allShipments
                                  .where((shipment) =>
                                      shipment.status == 'pending')
                                  .length,
                              itemBuilder: (context, index) {
                                var shipment = allShipments
                                    .where((shipment) =>
                                        shipment.status == 'pending')
                                    .toList()[index];
                                return _buildShipmentCard(shipment);
                              },
                            ),

                  // Tab 3 - Delivered Shipments
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : allShipments
                              .where(
                                  (shipment) => shipment.status == 'delivered')
                              .isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SvgPicture.asset(
                                  'assets/empty.svg',
                                  width: 300,
                                  height: 300,
                                ),
                                const SizedBox(height: 16.0),
                                CustomText(
                                  text: "No Shipments Available",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                                CustomText(
                                  text: "You haven't sent a product yet",
                                  fontSize: 8.sp,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: allShipments
                                  .where((shipment) =>
                                      shipment.status == 'delivered')
                                  .length,
                              itemBuilder: (context, index) {
                                var shipment = allShipments
                                    .where((shipment) =>
                                        shipment.status == 'delivered')
                                    .toList()[index];
                                return _buildShipmentCard(shipment);
                              },
                            ),
                ],
              )
            : Container(),
      ),
    );
  }

  Widget _buildShipmentCard(Shipment shipment) {
    // Function to format the date string
    String formatDate(String dateString) {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('d MMM yyyy').format(dateTime);
    }

    // Function to shorten the location names
    String shortenLocation(String location, {int maxLength = 15}) {
      if (location.length > maxLength) {
        return '${location.substring(0, maxLength)}...';
      }
      return location;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ShippingCards(
        trackingID: shipment.trackingNumber,
        status: shipment.status,
        fromLocation:
            shortenLocation(shipment.pickupAddress), // Shorten fromLocation
        toLocation:
            shortenLocation(shipment.receiverAddress), // Shorten toLocation
        fromDate: formatDate(shipment.createdAt.toString()),
        estimatedDate: formatDate(shipment.updatedAt.toString()),
        sender: shipment.senderName,
        weight: shipment.weightOfPackage.toString(),
        timelineData: [],
      ),
    );
  }
}
