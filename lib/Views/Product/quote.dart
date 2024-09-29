import 'package:dotted_line/dotted_line.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class Getquote extends ConsumerStatefulWidget {
  const Getquote({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetquoteState();
}

class _GetquoteState extends ConsumerState<Getquote> {
  
  TextEditingController sender = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController noofpackage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Get a quote'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              CustomTextFormField(
                  labelText: 'From *',
                  hintText: 'Send location',
                  controller: sender,
                  suffix: Image.asset('assets/location.png'),
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  labelText: 'Destination *',
                  hintText: 'Send location',
                  controller: destination,
                  suffix: Image.asset('assets/location.png'),
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  labelText: 'Weight of Package *',
                  hintText: '1',
                  controller: weight,
                  suffix: Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: 'Kg',
                      )),
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  labelText: 'No of Packages *',
                  hintText: '1',
                  controller: weight,
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.add,
                    color: btncolor,
                  ),
                  CustomText(
                    text: 'Add another package',
                    color: Colors.grey,
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              DottedLine(
                dashColor: Colors.grey,
              ),
              SizedBox(
                height: 2.h,
              ),
              ListTile(
                leading: Icon(
                  Icons.error,
                  size: 30,
                ),
                subtitle: CustomText(
                  text:
                      'Shipping cost will be clculated based on the number of package and the weight of package.',
                  fontSize: 6.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),


CustomButton(
  text: 'Get a Quote',
  onPressed: () {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 70.h,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Rates',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.close_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),
                    Divider(color: Colors.grey),
                    SizedBox(height: 2.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '800 Gwanzo, China',
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'Pick up Location',
                              fontSize: 6.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: 'Lagos Nigeria',
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'Destination Location',
                              fontSize: 6.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Divider(color: Colors.grey),

                    SizedBox(height: 3.h),
                    Container(
                      height: 10.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: btngrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFFFEFF0),
                          child: SvgPicture.asset('assets/ship.svg'),
                        ),
                        title: CustomText(
                          text: 'Cargo',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: CustomText(
                          text: '3-5 days',
                          color: const Color.fromARGB(255, 226, 217, 217),
                        ),
                        trailing: CustomText(
                          text: 'USD 20',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    Container(
                      height: 10.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: btngrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFFFEFF0),
                          child: SvgPicture.asset('assets/plane.svg'),
                        ),
                        title: CustomText(
                          text: 'Express',
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: CustomText(
                          text: '1-2 days',
                          color: const Color.fromARGB(255, 226, 217, 217),
                        ),
                        trailing: CustomText(
                          text: 'USD 40',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomButton(
                      text: 'Back to Home',
                      onPressed: () {},
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  },
),

            ],
          ),
        ),
      ),
    );
  }
}
