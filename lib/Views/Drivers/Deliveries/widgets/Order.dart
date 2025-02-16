import 'package:fama/Views/Drivers/Pickups/widgets/pickcard.dart';
import 'package:flutter/material.dart';



void showAcceptOrderSheet({
  required BuildContext context,
  required String title,
  required String deliveryTime,
  required String pickupLocation,
  required VoidCallback onAccept,
  required VoidCallback onDecline,
  required VoidCallback onSeeItems,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Icon at the Top Right
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            // Delivery Card
            NewDeliveryCard(
              title: title,
              deliveryTime: deliveryTime,
              pickupLocation: pickupLocation,
              onAccept: onAccept,
              onDecline: onDecline,
              onSeeItems: onSeeItems,
            ),
          ],
        ),
      );
    },
  );
}
