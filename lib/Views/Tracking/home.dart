import 'package:fama/Views/Shipments/widgets/shippingData.dart';
import 'package:fama/Views/Tracking/Api/trackingservice.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SearchHome extends StatefulWidget {
  const SearchHome({super.key});

  @override
  State<SearchHome> createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  TextEditingController searchController = TextEditingController();
  TrackingApiService trackingApiService = TrackingApiService();
  Shipment? shipment;
  bool isLoading = false;
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList('recentSearches') ?? [];
    setState(() {});
  }

  Future<void> _saveToRecent(String trackingCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.add(trackingCode);
    await prefs.setStringList('recentSearches', recentSearches);
    setState(() {});
  }

  Future<void> _clearAllRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recentSearches');
    setState(() {
      recentSearches.clear();
    });
  }

  Future<void> _removeFromRecent(String trackingCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.remove(trackingCode);
    await prefs.setStringList('recentSearches', recentSearches);
    setState(() {});
  }

  Future<void> _searchShipment() async {
    setState(() {
      isLoading = true;
    });

    String trackingCode = searchController.text;

    final result = await trackingApiService.fetchShipment(trackingCode);

    setState(() {
      shipment = result;
      isLoading = false;
    });

    if (result != null && !recentSearches.contains(trackingCode)) {
      _saveToRecent(trackingCode);
    }
  }

  void _setSearchText(String trackingCode) {
    searchController.text = trackingCode; // Populate the text field with the selected tracking code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(text: "Tracking"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: '',
              hintText: 'Enter Tracking Number',
              controller: searchController,
              onChanged: (value) {},
              suffix: GestureDetector(
                onTap: _searchShipment,
                child: Icon(Icons.qr_code_scanner),
              ),
            ),
            SizedBox(height: 10.0),
            // Show recent searches only if not loading and shipment is null
            if (!isLoading && shipment == null && recentSearches.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Recent",
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      _clearAllRecentSearches();
                    },
                    child: CustomText(
                      text: "Clear All",
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              // Display each recent tracking code as text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: recentSearches.map((trackingCode) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _setSearchText(trackingCode), // Set search text on tap
                            child: Text(
                              trackingCode, // Display tracking code
                              style: TextStyle(color: Colors.black), // Optional: make it look clickable
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => _removeFromRecent(trackingCode), // Remove tracking code on close
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            SizedBox(height: 10.0),
            isLoading
                ? CircularProgressIndicator(color: btncolor)
                : shipment != null
                    ? _buildShipmentCard(shipment!)
                    : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildShipmentCard(Shipment shipment) {
    String formatDate(String dateString) {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('d MMM yyyy').format(dateTime);
    }

    String shortenLocation(String location, {int maxLength = 15}) {
      return location.length > maxLength
          ? '${location.substring(0, maxLength)}...'
          : location;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ShippingCards(
        trackingID: shipment.trackingNumber,
        status: shipment.status.toString(),
        fromLocation: shortenLocation(shipment.pickupAddress.toString()),
        toLocation: shortenLocation(shipment.receiverAddress.toString()),
        fromDate: formatDate(shipment.createdAt.toString()),
        estimatedDate: formatDate(shipment.updatedAt.toString()),
        sender: shipment.senderName,
        weight: shipment.weightOfPackage.toString(),
        timelineData: [],
      ),
    );
  }
}


