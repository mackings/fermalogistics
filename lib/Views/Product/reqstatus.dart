import 'package:fama/Views/Tracking/widgets/thetimeline.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/customtimeline.dart';
import 'package:fama/Views/widgets/reqsummarycard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class requeststatus extends ConsumerStatefulWidget {
  const requeststatus({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _requeststatusState();
}

class _requeststatusState extends ConsumerState<requeststatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Request status",
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: btngrey, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
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
                height: 2.h,
              ),
              CustomText(
                text: "Request Details",
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              RSummaryCard(
                  title: "Mail Box",
                  subtitle: "100 Pcs",
                  leadingIcon: Icons.email,
                  trailingIcon: "Placed",
                  text1: "Text 1",
                  text2: "Text2",
                  imageUrl:
                      "https://itpulse.com.ng/wp-content/uploads/2024/05/dataaaaaaa.webp",
                  additionalText:
                      "I want the products secured and kept in a very good manner please"),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              height: 29.h,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "Cancel Request?",
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                         ),
                                        CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.black,
                                            child: Icon(
                                              Icons.close_outlined,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                SizedBox(
                                      height: 1.h,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(text: "This process can not be undone",
                                      color: btncolor,),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Divider(
                                      color: bggrey,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    CustomButton(
                                        text: "Delete Request",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      child: Center(
                          child: CustomText(
                        text: 'Cancel Request',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 250, 164, 173),
                          borderRadius: BorderRadius.circular(10)),
                      width: 37.w,
                      height: 6.h,
                    ),
                  ),
                  Container(
                    child: Center(
                        child: CustomText(
                      text: 'Edit Request',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                    decoration: BoxDecoration(
                        color: btncolor,
                        borderRadius: BorderRadius.circular(10)),
                    width: 37.w,
                    height: 6.h,
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
