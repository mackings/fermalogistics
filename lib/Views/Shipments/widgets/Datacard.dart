import 'package:fama/Views/Shipments/widgets/customerserv.dart';
import 'package:fama/Views/Tracking/live.dart';
import 'package:fama/Views/Tracking/widgets/thetimeline.dart';
import 'package:fama/Views/Tracking/widgets/timeline.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class MainTrackingDetails extends StatelessWidget {
  final String trackingID;
  final String status;
  final String fromLocation;
  final String toLocation;
  final String fromDate;
  final String estimatedDate;
  final String sender;
  final String weight;

  const MainTrackingDetails({
    Key? key,
    required this.trackingID,
    required this.status,
    required this.fromLocation,
    required this.toLocation,
    required this.fromDate,
    required this.estimatedDate,
    required this.sender,
    required this.weight,
  }) : super(key: key);

  List<TimelineData> _getTimelineData() {
    switch (status.toLowerCase()) {
      case 'pending':
        return [
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.transparent,
            afterLineColor: Colors.red,
          ),
          TimelineData(
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.red,
            afterLineColor: Colors.white,
          ),
          TimelineData(
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.white,
            afterLineColor: Colors.white,
          ),
          TimelineData(
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.white,
            afterLineColor: Colors.white,
          ),
        ];
      case 'shipping':
        return [
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.transparent,
            afterLineColor: Colors.red,
          ),
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.red,
            afterLineColor: Colors.red,
          ),
          TimelineData(
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.red,
            afterLineColor: Colors.white,
          ),
          TimelineData(
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.white,
            afterLineColor: Colors.white,
          ),
        ];
      case 'delivered':
        return [
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.transparent,
            afterLineColor: Colors.red,
          ),
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.red,
            afterLineColor: Colors.red,
          ),
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.red,
            afterLineColor: Colors.red,
          ),
          TimelineData(
            indicatorColor: Colors.red,
            beforeLineColor: Colors.red,
            afterLineColor: Colors.red,
          ),
        ];
      case 'cancelled':
        return [
          TimelineData(
            indicatorColor: Colors.grey,
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
            afterLineColor: Colors.white,
          ),
          TimelineData(
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.grey,
            afterLineColor: Colors.white,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TimelineData> timelineData = _getTimelineData(); // Fetch timeline data based on status

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
           text: "Tracking ID",
           fontSize: 10.sp,
       ), 

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              // Tracking Details Section
              Container(
                decoration: BoxDecoration(
                  color: btngrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Tracking ID",
                            fontSize: 12.sp,
                          ),
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
          CustomText(text: trackingID), // Assuming CustomText is your custom widget
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: trackingID));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tracking ID copied!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Icon(
              Icons.copy_all_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
                      SizedBox(height: 2.h),
                      Timelines(
                        firstTile: timelineData[0], // Use dynamic timeline data
                        middleTile1: timelineData[1],
                        middleTile2: timelineData[2],
                        lastTile: timelineData[3],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Created", color: Colors.grey),
                              CustomText(
                                text: fromDate,
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
                      // Product Detail
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
              ),
              SizedBox(height: 5.h),
              CustomerService(
                name: "Mac Kingsley",
                title: "Customer Services",
                onCallPressed: () {
                  // Handle call action
                },
                onEmailPressed: () {
                  // Handle email action
                },
              ),
              SizedBox(height: 5.h),

Container(
  decoration: BoxDecoration(
    color: btngrey,
    borderRadius: BorderRadius.circular(15),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [

        CustomTimelineTile(
          title: "Order Placed",
          subtitle: "An order has been placed.",
          date: fromDate,
          time: "03:00",
          isFirst: true,
          isActive: status.toLowerCase() == "pending" || status.toLowerCase() == "shipping" || status.toLowerCase() == "delivered",
        ),

        CustomTimelineTile(
          title: "Processing",
          subtitle: "Your order is being processed.",
          date: fromDate,
          time: "03:15",
          isActive: status.toLowerCase() == "shipping" || status.toLowerCase() == "delivered",
        ),

        CustomTimelineTile(
          title: "Packed",
          date: estimatedDate,
          time: "00:00",
          isActive: status.toLowerCase() == "delivered",
        ),

        CustomTimelineTile(
          title: "Shipping",
          date: estimatedDate,
          time: "00:00",
          isActive: status.toLowerCase() == "delivered",
        ),

        CustomTimelineTile(
          title: "Delivered",
          date: "DD/MM/YY",
          time: "00:00",
          isLast: true,
          isActive: status.toLowerCase() == "delivered",
        ),
        
      ],
    ),
  ),
),


              SizedBox(height: 5.h),
              CustomButton(
                text: "Live Tracking",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LiveTracking()),
                  );
                },
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

