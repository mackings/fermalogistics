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
    return Container(
      height: 30.h,
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
                  fontSize: 12.sp,
                ),
                Container(
                  height: 40,
                  width: 90,
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
              child: CustomText(text: "LKNVNM"),
            ),
            SizedBox(height: 2.h),
            //Timelines(),
             Timelines(
                firstTile: TimelineData(
                  indicatorColor: Colors.blue,
                  beforeLineColor: Colors.transparent,
                  afterLineColor: Colors.grey,
                ),
                middleTile1: TimelineData(
                  indicatorColor: Colors.green,
                  beforeLineColor: Colors.blue,
                  afterLineColor: Colors.grey,
                ),
                middleTile2: TimelineData(
                  indicatorColor: Colors.orange,
                  beforeLineColor: Colors.green,
                  afterLineColor: Colors.grey,
                ),
                lastTile: TimelineData(
                  indicatorColor: Colors.red,
                  beforeLineColor: Colors.orange,
                  afterLineColor: Colors.transparent,
                ),
             ),

            CustomText(text: 'Yooo')
          ],
        ),
      ),
    );
  }
}
