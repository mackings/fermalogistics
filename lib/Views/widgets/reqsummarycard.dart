import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RSummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final String trailingIcon;
  final String text1;
  final String text2;
  final String imageUrl;
  final String additionalText;

  const RSummaryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.text1,
    required this.text2,
    required this.imageUrl,
    required this.additionalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 70.h,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: btngrey,
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(leadingIcon),
                ),
                title: CustomText(
                  text: title,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: Text(subtitle),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 160, 41, 33),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: CustomText(
                    text: trailingIcon,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Time Placed',
                          color: Colors.grey,
                          fontSize: 7.sp,
                        ),
                        CustomText(
                          text: '8:27 AM',
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Date Placed',
                          color: Colors.grey,
                          fontSize: 7.sp,
                        ),
                        CustomText(
                          text: '1 July, 2025',
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                    
               SizedBox(height: 2.h),
                    
               Divider(
                color: Colors.white,
              ),
          
              SizedBox(height: 2.h),
                    
                            Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'No of packages',
                          color: Colors.grey,
                          fontSize: 7.sp,
                        ),
                        CustomText(
                          text: '100 Pieces',
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Date Placed',
                          color: Colors.grey,
                          fontSize: 7.sp,
                        ),
                        CustomText(
                          text: '1 July, 2025',
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                    
              SizedBox(height: 2.h), 
             
              Container(
                height: 20.h,
                width: MediaQuery.of(context).size.width -10,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  border: Border.all(width: 1.5,color: Colors.white)
                ),
               // alignment: Alignment.center,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10), 
              
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomText(
                    text: additionalText,
                    color: Colors.black,
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              
              SizedBox(height: 1.h,),
                    
            ],
          ),
        ),
      ),
    );
  }
}
