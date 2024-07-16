import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RequestCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final String trailingIcon;
  final String text1;
  final String text2;

  const RequestCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 20.h, // Set the height of the Container
      decoration: BoxDecoration(
        color: Colors.white, // Adjust the color if necessary
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 20.h - 20, // Adjust the height to fit within the Container's padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(leadingIcon),
                ),
                title: CustomText(text: title, fontWeight: FontWeight.w500,),
                subtitle: Text(subtitle),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: CustomText(text: trailingIcon, color: Colors.white,)
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: 'Time Placed', color: Colors.grey, fontSize: 7.sp,),
                        CustomText(text: '8:27 AM', color: Colors.black, fontSize: 8.sp, fontWeight: FontWeight.w700,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(text: 'Date Placed', color: Colors.grey, fontSize: 7.sp,),
                        CustomText(text: '1 July, 2025', color: Colors.black, fontSize: 8.sp, fontWeight: FontWeight.w700,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
