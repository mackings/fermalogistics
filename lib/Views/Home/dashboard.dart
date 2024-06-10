
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/homecard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:fama/Views/widgets/tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(child: Icon(Icons.person),),

                  Column(
                    children: [
                      CustomText(
                        text: 'Current Location',
                        fontSize: 7.sp,
                        color: Colors.grey
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.location_on),
                            CustomText(text: 'Lagos, Nigeria',fontWeight: FontWeight.w600,),
                            Icon(Icons.arrow_drop_down_outlined)
                          ],
                        )
                    ],
                  ),

                  Container(
                    height: 6.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                      color: btngrey,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Icon(Icons.notifications_outlined)
                    )
                ],
              ),
              SizedBox(height: 3.h,),

              ShipmentTrackingCard(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomText(
                    text: 'Our Services',
                    fontWeight: FontWeight.w700,
                    )
                  ],
                ),
              ),

              ShipmentOptions(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                    text: 'Recent Shipping',
                    fontWeight: FontWeight.w700,
                    ),

                    CustomText(text: 'See all',color: btngrey,)
                  ],
                ),
              ),

              Shipments()

            ],
          ),
        ),
      ),
    );
  }
}