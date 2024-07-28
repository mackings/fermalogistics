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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Request status",fontWeight: FontWeight.w600,fontSize: 12.sp,),
              SizedBox(height: 2.h,),
        
        
              Container(
                decoration: BoxDecoration(
                  color: btngrey,
                  borderRadius: BorderRadius.circular(10)
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                  
                                      TimelineTile(
                                         isFirst: true,
                                         hasIndicator: true,
                                         indicatorStyle: IndicatorStyle(
                      
                      height: 30,
                      width: 30,
                      indicator: CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 5,),
                      )
                                         ),
                      endChild: ListTile(
                        title: CustomText(text: "Request Accepted"),
                        subtitle: CustomText(text: "Incoming"),
                      )
                                        
                                        ),
                  
                                      TimelineTile(
                                         hasIndicator: true,
                                         indicatorStyle: IndicatorStyle(
                      color: Colors.red,
                      height: 30,
                      width: 30,
                      indicator: CircleAvatar(
                        radius: 90,
                      )
                                         ),
                      endChild: ListTile(
                        title: CustomText(text: "Request Accepted"),
                        subtitle: CustomText(text: "Incoming"),
                      )
                                        
                                        ),
                                      TimelineTile(
                                         isLast: true,
                                         hasIndicator: true,
                                         indicatorStyle: IndicatorStyle(
                      color: Colors.red,
                      height: 30,
                      width: 30,
                      indicator: CircleAvatar(
                        radius: 90,
                      )
                                         ),
                      endChild: ListTile(
                        title: CustomText(text: "Request Accepted"),
                        subtitle: CustomText(text: "Incoming"),
                      )
                                        
                                        ),
                    ],
                  ),
                ),
              ),
        
        
              RSummaryCard(
                title: "", 
                subtitle: "", 
                leadingIcon: Icons.email,
                 trailingIcon: "Trailing",
                  text1: "Text 1", 
                  text2: "Text2", 
                  imageUrl: "https://itpulse.com.ng/wp-content/uploads/2024/05/dataaaaaaa.webp",
                  additionalText: "I want the products secured and kept in a very good manner please"
                  ),
                   SizedBox(height: 3.h,),


                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    child: Center(child: CustomText(text: 'Cancel Request',color: Colors.white,fontWeight:FontWeight.w600 ,)),
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 250, 164, 173),
                    borderRadius: BorderRadius.circular(10)),
                    width: 37.w,
                    height: 6.h,
                  ),

                                    Container(
                    child: Center(child: CustomText(text: 'Edit Request',color: Colors.white,fontWeight:FontWeight.w600 ,)),
                    decoration: BoxDecoration(color: btncolor,
                    borderRadius: BorderRadius.circular(10)),
                    width: 37.w,
                    height: 6.h,
                  )

                ],
              ),
              SizedBox(height: 5.h,)
        
             
            ],
          ),
        ),
      ),
    );
  }
}