import 'package:fama/Views/Product/Model/requests.dart';
import 'package:fama/Views/Tracking/widgets/requestTimeline.dart';
import 'package:fama/Views/Tracking/widgets/thetimeline.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/customtimeline.dart';
import 'package:fama/Views/widgets/reqsummarycard.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class requeststatus extends ConsumerStatefulWidget {
  final Request request;
  const requeststatus({Key? key, required this.request}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _requeststatusState();
}

class _requeststatusState extends ConsumerState<requeststatus> {
  @override
  Widget build(BuildContext context) {
    final request = widget.request;

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
              SizedBox(height: 2.h),

Container(
  decoration: BoxDecoration(
    color: btngrey,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
    child: Column(
      children: [
        CustomRequestTimelineTile(
          title: "Request Placed",
          subtitle: "We have received your request",
          date: DateFormat('d MMM yyyy').format(request.createdAt),
          time: DateFormat('HH:mm').format(request.createdAt),
          isFirst: true,
          isActive: request.status == "placed" ||
                    request.status == "processing" ||
                    request.status == "delivered",
        ),
        CustomRequestTimelineTile(
          title: "Request Processed",
          subtitle: "We will soon give you feedback",
          date: DateFormat('d MMM yyyy').format(request.updatedAt),
          time: DateFormat('HH:mm').format(request.updatedAt),
          isActive: request.status == "processing" ||
                    request.status == "delivered",
        ),
        CustomRequestTimelineTile(
          title: "Request Delivered",
          subtitle: "Check your notification",
          date: DateFormat('d MMM yyyy').format(request.updatedAt),
          time: DateFormat('HH:mm').format(request.updatedAt),
          isLast: true,
          isActive: request.status == "delivered",
        ),
      ],
    ),
  ),
),



              SizedBox(height: 2.h),
              CustomText(
                text: "Request Details",
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              GestureDetector(
                onTap: () {
                  print(request.createdAt);
                  print(request.updatedAt);
                },
                child: RSummaryCard(
                  title: request.user.fullName,
                  subtitle: '${request.quantity} Pcs',
                  leadingImageUrl: request.productImage,
                  trailingIcon: request.status,
                  dateTimePlaced: request.createdAt,
                  numberOfPackages: request.quantity.toString(),
                  imageUrl: request.productImage,
                  additionalText: request.additionalInfo,
                ),
              ),
              SizedBox(height: 3.h),
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  SizedBox(height: 3.h),
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
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      text: "This process cannot be undone",
                                      color: btncolor,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Divider(color: bggrey),
                                  SizedBox(height: 1.h),
                                  CustomButton(
                                    text: "Delete Request",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Center(
                        child: CustomText(
                          text: 'Cancel Request',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 164, 173),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: btncolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 37.w,
                    height: 6.h,
                  )
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
