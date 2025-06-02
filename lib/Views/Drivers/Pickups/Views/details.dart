import 'package:getnamibia/Views/Drivers/Pickups/Apis/pickupservice.dart';
import 'package:getnamibia/Views/Drivers/Pickups/Models/pickupmodel.dart';
import 'package:getnamibia/Views/Drivers/Pickups/Views/complete.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupDetailsPage extends StatefulWidget {
  final SendOrder upcomingOrder;

  const PickupDetailsPage({
    Key? key,
    required this.upcomingOrder,
  }) : super(key: key);

  @override
  State<PickupDetailsPage> createState() => _PickupDetailsPageState();
}

class _PickupDetailsPageState extends State<PickupDetailsPage> {
  bool isLoading = false; // Track loading state

  void _showConfirmPickupModal(BuildContext context, SendOrder upcomingOrder) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close Icon at the Top Right
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const CircleAvatar(
                          child: Icon(Icons.close, color: Colors.black)),
                      onPressed:
                          isLoading ? null : () => Navigator.pop(context),
                    ),
                  ),

                  // Title
                  const Text(
                    "Confirm Pickup",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Confirmation Message
                  const Text(
                    "Are you sure you want to confirm this pickup?",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // "No" Button (Outlined)
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              isLoading ? null : () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "No",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // "Yes" Button (Filled with border radius)
                      Expanded(
                        child: GestureDetector(
                          onTap: isLoading
                              ? null
                              : () async {
                                  setModalState(() => isLoading = true);
                                  await _confirmPickup(
                                      context, upcomingOrder, setModalState);
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _confirmPickup(BuildContext context, SendOrder upcomingOrder,
      StateSetter setModalState) async {
    String orderId = upcomingOrder.id.toString();
    PickupService pickupService = PickupService();

    Map<String, dynamic> response = {
      'success': false,
      'message': 'Unknown error'
    };

    try {
      response = await pickupService.confirmPickup(orderId);
    } catch (e) {
      debugPrint("Error confirming pickup: $e");
    }

    if (mounted) {
      Navigator.pop(context); // Close modal

      bool shouldNavigate = response['success'] == true ||
          response['message'].contains("Order has already been in-transit")||
          response['message'].contains('Order has already been marked as in-transit') ;

      if (shouldNavigate) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CompleteDelivery(upcomingOrder: upcomingOrder),
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Extract the first item from cartItems (if available)
    CartItem? firstItem = (widget.upcomingOrder.cartItems != null &&
            widget.upcomingOrder.cartItems!.isNotEmpty)
        ? widget.upcomingOrder.cartItems!.first
        : null;

    // Check if firstItem exists, otherwise use fallback fields from upcomingOrder
    String productName =
        firstItem?.productName ?? widget.upcomingOrder.itemName ?? "No Product";
    String productImage = (firstItem?.picture?.isNotEmpty ?? false)
        ? firstItem!.picture!
        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4-3LBr4VIyjyAUBLWARVx5IekuoisQ5BQN5hlGbfuUBda44U7BMJuU9FUF91zir5xt0o&usqp=CAU";
    double productPrice =
        firstItem?.price ?? widget.upcomingOrder.totalAmount ?? 0.0;
    int productQuantity =
        firstItem?.quantity ?? widget.upcomingOrder.numberOfPackages ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Pickup details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png"), // Replace with actual profile image
                    radius: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.upcomingOrder.userId!.fullName.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.upcomingOrder.userId!.phoneNumber.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.phone, color: Colors.green),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.message, color: Colors.blue),
                      onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Product Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      productImage,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${widget.upcomingOrder.amount == null ? productPrice.toStringAsFixed(2) : widget.upcomingOrder.amount}",
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "x$productQuantity",
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(),
            const SizedBox(height: 16),

            // Order Number
            Text(
              // "Order number: #${upcomingOrder.orderId == null? upcomingOrder.trackingNumber:"N/A"}",
              "Order number: #${widget.upcomingOrder.trackingNumber == null ? widget.upcomingOrder.orderId : widget.upcomingOrder.trackingNumber}",
              style:
                  GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "Use this ID at warehouse to pickup order instead of customer’s name",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Arrival Instructions
            Text(
              "Upon Arrival",
              style:
                  GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "Remember to check receipts and make sure it corresponds with the order.",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 140),

            CustomButton(
              text: "Confirm Pickup",
              onPressed: () {
                _showConfirmPickupModal(context, widget.upcomingOrder);
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
