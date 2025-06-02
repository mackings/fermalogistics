import 'package:getnamibia/Views/Tracking/widgets/timeline.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TrackingInfoCard extends StatelessWidget {
  
  final String trackingId;
  final String status;
  final String createdDate;
  final String estimatedDate;
  final String fromLocation;
  final String toLocation;
  final String sender;
  final String weight;

  const TrackingInfoCard({
    Key? key,
    required this.trackingId,
    required this.status,
    required this.createdDate,
    required this.estimatedDate,
    required this.fromLocation,
    required this.toLocation,
    required this.sender,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: btngrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Tracking ID", fontSize: 12.sp),
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: CustomText(
                      text: status,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  CustomText(text: trackingId),
                  SizedBox(width: 2.w),
                  Icon(Icons.copy_all_outlined, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Timelines(
              firstTile: TimelineData(
                indicatorColor: btncolor,
                beforeLineColor: Colors.transparent,
                afterLineColor: btncolor,
              ),
              middleTile1: TimelineData(
                indicatorColor: btncolor,
                beforeLineColor: btncolor,
                afterLineColor: btncolor,
              ),
              middleTile2: TimelineData(
                indicatorColor: Colors.red,
                beforeLineColor: btncolor,
                afterLineColor: Colors.white,
              ),
              lastTile: TimelineData(
                indicatorColor: Colors.red,
                beforeLineColor: Colors.white,
                afterLineColor: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Created", color: Colors.grey),
                    CustomText(
                      text: createdDate,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(text: "Estimated", color: Colors.grey),
                    CustomText(
                      text: estimatedDate,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "From", color: Colors.grey),
                    CustomText(
                      text: fromLocation,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(text: "To", color: Colors.grey),
                    CustomText(
                      text: toLocation,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 2.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Sender", color: Colors.grey),
                    CustomText(
                      text: sender,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(text: "Weight", color: Colors.grey),
                    CustomText(
                      text: weight,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
