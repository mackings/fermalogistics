import 'package:getnamibia/Views/Shipments/widgets/Datacard.dart';
import 'package:getnamibia/Views/Tracking/widgets/timeline.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
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
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.transparent, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.red, afterLineColor: Colors.white),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.white, afterLineColor: Colors.white),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.white, afterLineColor: Colors.white),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.white, afterLineColor: Colors.transparent),
      ];
    case 'processing':
      return [
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.transparent, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.red, afterLineColor: Colors.white),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.white, afterLineColor: Colors.white),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.white, afterLineColor: Colors.transparent),
      ];
    case 'in-transit':
      return [
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.transparent, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.red, afterLineColor: Colors.white),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.white, afterLineColor: Colors.transparent),
      ];
    case 'arrived':
      return [
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.transparent, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.red, afterLineColor: Colors.transparent),
      ];
    case 'completed':
      return [
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.transparent, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.red),
        TimelineData(indicatorColor: Colors.red, beforeLineColor: Colors.red, afterLineColor: Colors.transparent),
      ];
    case 'cancelled':
      return [
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.transparent, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.transparent),
      ];
    default:
      return [
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.transparent, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.grey),
        TimelineData(indicatorColor: Colors.grey, beforeLineColor: Colors.grey, afterLineColor: Colors.transparent),
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
