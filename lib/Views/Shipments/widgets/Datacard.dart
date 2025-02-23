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

class MainTrackingDetails extends StatefulWidget {
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

  @override
  State<MainTrackingDetails> createState() => _MainTrackingDetailsState();
}

class _MainTrackingDetailsState extends State<MainTrackingDetails> {
  late List<TimelineData> timelineData;

  @override
  void initState() {
    super.initState();
    timelineData = _getTimelineData(widget.status);
  }

  @override
  void didUpdateWidget(MainTrackingDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      setState(() {
        timelineData = _getTimelineData(widget.status);
      });
    }
  }

  List<TimelineData> _getTimelineData(String status) {
    switch (widget.status.toLowerCase()) {
      case 'pending':
        return [
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.white),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.white,
              afterLineColor: Colors.white),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.white,
              afterLineColor: Colors.white),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.white,
              afterLineColor: Colors.transparent),
        ];
      case 'processing':
        return [
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.white),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.white,
              afterLineColor: Colors.white),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.white,
              afterLineColor: Colors.transparent),
        ];
      case 'in-transit':
        return [
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.white),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.white,
              afterLineColor: Colors.transparent),
        ];
      case 'arrived':
        return [
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.transparent),
        ];
      case 'completed':
        return [
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.red),
          TimelineData(
              indicatorColor: Colors.red,
              beforeLineColor: Colors.red,
              afterLineColor: Colors.transparent),
        ];
      case 'cancelled':
        return [
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.transparent),
        ];
      default:
        return [
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.transparent,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.grey),
          TimelineData(
              indicatorColor: Colors.grey,
              beforeLineColor: Colors.grey,
              afterLineColor: Colors.transparent),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                text: widget.status,
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
                            CustomText(
                                text: widget
                                    .trackingID), // Assuming CustomText is your custom widget
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: widget.trackingID));
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
                        firstTile: timelineData[0],
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
                                text: widget.fromDate,
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
                                text: widget.estimatedDate,
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
                                text: widget.fromLocation,
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
                                text: widget.toLocation,
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
                                text: widget.sender,
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
                                text: widget.weight,
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
                        date: widget.fromDate,
                        isFirst: true,
                        isActive: widget.status.toLowerCase() != "cancelled",
                        indicatorColor: timelineData[0].indicatorColor,
                        beforeLineColor: timelineData[0].beforeLineColor,
                        afterLineColor: timelineData[0].afterLineColor,
                      ),
                      CustomTimelineTile(
                        title: "Processing",
                        subtitle: "Your order is being processed.",
                        date: widget.fromDate,
                        // time: "03:15",
                        isActive: widget.status.toLowerCase() == "processing" ||
                            widget.status.toLowerCase() == "shipping" ||
                            widget.status.toLowerCase() == "delivered",
                        indicatorColor: timelineData[1].indicatorColor,
                        beforeLineColor: timelineData[1].beforeLineColor,
                        afterLineColor: timelineData[1].afterLineColor,
                      ),
                      CustomTimelineTile(
                        title: "Packed",
                        //date: estimatedDate,
                        subtitle: "Your order has been packed for shipment",
                        date: "",
                        // time:"Your order has been packed for shipment",
                        isActive: widget.status.toLowerCase() == "shipping" ||
                            widget.status.toLowerCase() == "delivered",
                        indicatorColor: timelineData[2].indicatorColor,
                        beforeLineColor: timelineData[2].beforeLineColor,
                        afterLineColor: timelineData[2].afterLineColor,
                      ),
                      CustomTimelineTile(
                        title: "Shipping",
                        subtitle: "Your order has reached your region",
                        date: "",
                        isActive: widget.status.toLowerCase() == "delivered",
                        indicatorColor: timelineData[3].indicatorColor,
                        beforeLineColor: timelineData[3].beforeLineColor,
                        afterLineColor: timelineData[3].afterLineColor,
                      ),
                      CustomTimelineTile(
                        title: "Delivered",
                        subtitle: "Your order has been delivered",
                        date: "",
                        // time: "00:00",
                        isLast: true,
                        isActive: widget.status.toLowerCase() == "delivered",
                        indicatorColor: timelineData[4].indicatorColor,
                        beforeLineColor: timelineData[4].beforeLineColor,
                        afterLineColor: timelineData[4].afterLineColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5.h),

              CustomButton(
                text: "Continue",
                onPressed: () {
                  Navigator.pop(context);
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
