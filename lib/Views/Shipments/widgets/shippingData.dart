import 'package:fama/Views/Shipments/widgets/Datacard.dart';
import 'package:fama/Views/Tracking/widgets/timeline.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ShippingCards extends StatelessWidget {

  final String trackingID;
  final String status;
  final String fromLocation;
  final String toLocation;
  final String fromDate;
  final String estimatedDate;
  final String sender;
  final String weight;
  final List<TimelineData> timelineData;

  const ShippingCards({
    Key? key,
    required this.trackingID,
    required this.status,
    required this.fromLocation,
    required this.toLocation,
    required this.fromDate,
    required this.sender,
    required this.weight,
    required this.estimatedDate,
    required this.timelineData,
  }) : super(key: key);




List<TimelineData> _getTimelineData() {
  switch (status.toLowerCase()) {
    case 'pending':
      return [
        TimelineData(
          indicatorColor: Colors.red, // First dot red
          beforeLineColor: Colors.transparent, // No line before the first dot
          afterLineColor: Colors.red, // Color for the line after the first dot
        ),
        TimelineData(
          indicatorColor: Colors.grey, // Second dot grey
          beforeLineColor: Colors.red, // Line from the first to the second dot
          afterLineColor: Colors.white, // Line after the second dot
        ),
        TimelineData(
          indicatorColor: Colors.grey, // Third dot grey
          beforeLineColor: Colors.white, // Line before the third dot
          afterLineColor: Colors.white, // Change this to white
        ),
        TimelineData(
          indicatorColor: Colors.grey, // Fourth dot grey
          beforeLineColor: Colors.white, // Line before the fourth dot
          afterLineColor: Colors.white, // Change this to white
        ),
      ];
    case 'shipping':
      return [
        TimelineData(
          indicatorColor: Colors.red, // First dot red
          beforeLineColor: Colors.transparent,
          afterLineColor: Colors.red,
        ),
        TimelineData(
          indicatorColor: Colors.red, // Second dot red
          beforeLineColor: Colors.red,
          afterLineColor: Colors.red, // Line after the second dot
        ),
        TimelineData(
          indicatorColor: Colors.grey, // Third dot grey
          beforeLineColor: Colors.red, // Line before the third dot
          afterLineColor: Colors.white, // Change this to white
        ),
        TimelineData(
          indicatorColor: Colors.grey, // Fourth dot grey
          beforeLineColor: Colors.white, // Line before the fourth dot
          afterLineColor: Colors.white, // Change this to white
        ),
      ];
    case 'delivered':
      return [
        TimelineData(
          indicatorColor: Colors.red, // First dot red
          beforeLineColor: Colors.transparent, // No line before the first dot
          afterLineColor: Colors.red, // Color for the line after the first dot
        ),
        TimelineData(
          indicatorColor: Colors.red, // Second dot red
          beforeLineColor: Colors.red, // Line from first to second
          afterLineColor: Colors.red, // Line after the second dot
        ),
        TimelineData(
          indicatorColor: Colors.red, // Third dot red
          beforeLineColor: Colors.red, // Line from second to third
          afterLineColor: Colors.red, // Line after the third dot
        ),
        TimelineData(
          indicatorColor: Colors.red, // Fourth dot red
          beforeLineColor: Colors.red, // Line from third to fourth
          afterLineColor: Colors.red, // Line after the fourth dot
        ),
      ];
    case 'cancelled':
      return [
        TimelineData(
          indicatorColor: Colors.grey, // All dots grey
          beforeLineColor: Colors.transparent,
          afterLineColor: Colors.grey,
        ),
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.grey,
          afterLineColor: Colors.grey,
        ),
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.grey,
          afterLineColor: Colors.grey,
        ),
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.grey,
          afterLineColor: Colors.grey,
        ),
      ];
    default:
      return [
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.transparent,
          afterLineColor: Colors.grey,
        ),
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.white,
          afterLineColor: Colors.grey,
        ),
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.white,
          afterLineColor: Colors.white, // Change this to white
        ),
        TimelineData(
          indicatorColor: Colors.grey,
          beforeLineColor: Colors.grey,
          afterLineColor: Colors.white, // Change this to white
        ),
      ];
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainTrackingDetails(
                  
                  trackingID: trackingID,
                  status: status,
                  fromLocation: fromLocation,
                  toLocation: toLocation,
                  fromDate: fromDate,
                  estimatedDate: estimatedDate,
                  sender: sender,
                  weight: weight,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: btngrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Tracking ID",
                        fontSize: 9.sp,
                      ),
                      Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          color: btncolor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: CustomText(
                            text: status,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: trackingID,
                      fontSize: 9.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Timelines(
                    firstTile: _getTimelineData()[0],
                    middleTile1: _getTimelineData()[1],
                    middleTile2: _getTimelineData()[2],
                    lastTile: _getTimelineData()[3],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: fromDate,
                            color: Colors.grey,
                          ),
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
                          CustomText(
                            text: "Est $estimatedDate",
                            color: Colors.grey,
                          ),
                          CustomText(
                            text: toLocation,
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
          ),
        ),
      ],
    );
  }
}
