import 'package:fama/Views/Tracking/live.dart';
import 'package:fama/Views/Tracking/widgets/thetimeline.dart';
import 'package:fama/Views/Tracking/widgets/timeline.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TrackingDetails extends StatefulWidget {
  const TrackingDetails({super.key});

  @override
  State<TrackingDetails> createState() => _TrackingDetailsState();
}

class _TrackingDetailsState extends State<TrackingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: btngrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
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
                                text: 'In Transit',
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            CustomText(text: "LKNVNM"),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(
                              Icons.copy_all_outlined,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      //Timelines(),
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
                              CustomText(
                                text: "Created",
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "06 March 2024",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "Estimated",
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "18 March 2024",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "From",
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "China",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "To",
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "Nigeria",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Sender",
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "Toluwani",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "Weight",
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: "2.5Kg",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: btngrey, borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: CustomText(
                      text: "Mac Kingsley",
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle: CustomText(
                      text: "Customer Services",
                      color: Colors.grey,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: btngrey, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTimelineTile(
                        title: "Request Placed",
                        subtitle: "We have received your request",
                        date: "7th Dec 2024",
                        time: "18:00",
                        isFirst: true,
                      ),
                      CustomTimelineTile(
                        title: "Request Processed",
                        subtitle: "We will soon give you feedback",
                        date: "7th Dec 2024",
                        time: "18:00",
                      ),
                      CustomTimelineTile(
                        title: "Request Delivered",
                        subtitle: "Check your notification",
                        date: "7th Dec 2024",
                        time: "18:00",
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomButton(
                  text: "Live Tracking",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveTracking()));
                  }),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
