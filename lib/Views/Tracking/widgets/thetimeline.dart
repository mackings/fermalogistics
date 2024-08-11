import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final bool isFirst;
  final bool isLast;

  const CustomTimelineTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      hasIndicator: true,
      indicatorStyle: IndicatorStyle(
        height: 30,
        width: 30,
        indicator: CircleAvatar(
          radius: 90,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 5,
          ),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4.0),
                  CustomText(
                    text: subtitle,
                    fontSize: 6.sp,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: date,
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4.0),
                  CustomText(
                    text: time,
                    fontSize: 6.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}