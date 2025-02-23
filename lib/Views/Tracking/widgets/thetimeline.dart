
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';


class CustomTimelineTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  final String? time;
  final bool isFirst;
  final bool isLast;
  final bool isActive;
  final Color indicatorColor;
  final Color beforeLineColor;
  final Color afterLineColor;

  const CustomTimelineTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.date,
    this.time,
    this.isFirst = false,
    this.isLast = false,
    this.isActive = false,
    required this.indicatorColor,
    required this.beforeLineColor,
    required this.afterLineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;

    switch (title) {
      case "Order Placed":
        icon = Icons.shopping_cart;
        break;
      case "Processing":
        icon = Icons.sync;
        break;
      case "Packed":
        icon = Icons.inventory;
        break;
      case "Shipping":
        icon = Icons.local_shipping;
        break;
      case "Delivered":
        icon = Icons.check_circle;
        break;
      default:
        icon = Icons.radio_button_unchecked;
    }

    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      hasIndicator: true,
      beforeLineStyle: LineStyle(
        color: beforeLineColor,
        thickness: 2.0,
      ),
      afterLineStyle: LineStyle(
        color: afterLineColor,
        thickness: 2.0,
      ),
      indicatorStyle: IndicatorStyle(
        height: 30,
        width: 30,
        indicator: CircleAvatar(
          radius: 15,
          backgroundColor: indicatorColor,
          child: Icon(
            icon,
            color: isActive || indicatorColor == Colors.red ? Colors.white : Colors.grey.shade600,
            size: 18,
          ),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 4.0),
            if (subtitle != null)
              CustomText(
                text: subtitle!,
                fontSize: 12,
              ),
            const SizedBox(height: 4.0),
            CustomText(
              text: "$date${time != null ? ', $time' : ''}",
              fontSize: 12,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}



