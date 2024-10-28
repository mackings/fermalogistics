import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';


class CustomTimelineTile extends StatelessWidget {
  final String title;
  final String? subtitle; // Subtitle can now be null
  final String date;
  final String? time;
  final bool isFirst;
  final bool isLast;
  final bool isActive;

  const CustomTimelineTile({
    Key? key,
    required this.title,
    this.subtitle, // Make subtitle optional
    required this.date,
    this.time,
    this.isFirst = false,
    this.isLast = false,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    // Determine icon based on the title
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
      indicatorStyle: IndicatorStyle(
        height: 30,
        width: 30,
        indicator: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: isActive ? btncolor : Colors.grey,
            size: 18,
          ),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 4.0),
            if (subtitle != null) // Conditionally render the subtitle
              CustomText(
                text: subtitle!,
                fontSize: 6.sp,
              ),
            SizedBox(height: 4.0),
            CustomText(
              text: "$date${time != null ? ', $time' : ''}", // Include time only if it's not null
              fontSize: 6.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
