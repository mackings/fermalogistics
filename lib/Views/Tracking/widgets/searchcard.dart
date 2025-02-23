import 'package:fama/Views/Tracking/trackingdetails.dart';
import 'package:fama/Views/Tracking/widgets/timeline.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';



class SearchCard extends StatefulWidget {
  const SearchCard({super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {

  TextEditingController Search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => TrackingDetails()));
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
                            text: 'In Transit',
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(text: "234003",fontSize: 9.sp,),
                  ),

                  SizedBox(height: 2.h),

                  Timelines(
                    firstTile: TimelineData(
                      indicatorColor: btncolor,
                      beforeLineColor: Colors.transparent,
                      afterLineColor: btngrey,
                    ),
                    middleTile1: TimelineData(
                      indicatorColor: btncolor,
                      beforeLineColor: Colors.white,
                      afterLineColor: Colors.white,
                    ),
                    middleTile2: TimelineData(
                      indicatorColor: Colors.red,
                      beforeLineColor: Colors.white,
                      afterLineColor: Colors.grey,
                    ),
                    lastTile: TimelineData(
                      indicatorColor: Colors.red,
                      beforeLineColor: Colors.grey,
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
                            text: "06 March 2024",
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
                            text: "Estimated 06 March 2024",
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
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
