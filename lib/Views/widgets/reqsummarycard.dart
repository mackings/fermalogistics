import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RSummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leadingImageUrl;
  final String trailingIcon;
  final DateTime dateTimePlaced;
  final String numberOfPackages;
  final String imageUrl;
  final String additionalText;

  const RSummaryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingImageUrl,
    required this.trailingIcon,
    required this.dateTimePlaced,
    required this.numberOfPackages,
    required this.imageUrl,
    required this.additionalText,
  }) : super(key: key);

  String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime); // Format to time like 3:48 PM
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMM d, y').format(dateTime); // Format to date like Sep 2, 2024
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15,),
      decoration: BoxDecoration(
        color: btngrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the container circular
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(leadingImageUrl),
                  radius: 24, // Adjust radius as needed
                ),
              ),
              title: CustomText(
                text: title,
                fontWeight: FontWeight.w500,
              ),
              subtitle: Text(subtitle),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: CustomText(
                  text: trailingIcon,
                  color: Colors.white,
                ),
              ),
            ),
            Divider(color: Colors.white),

            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimePlaced(time: formatTime(dateTimePlaced)), // Format and pass the time
                  DatePlaced(date: formatDate(dateTimePlaced)), // Format and pass the date
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Divider(color: Colors.white),

            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NumberOfPackages(numberOfPackages: numberOfPackages),
                  DatePlaced(date: formatDate(dateTimePlaced)),  // Reused DatePlaced widget
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 20.h,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.5, color: Colors.white),
              ),
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
                borderRadius: BorderRadius.circular(10),
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
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}


class TimePlaced extends StatelessWidget {
  final String time;

  const TimePlaced({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Time Placed',
          color: Colors.grey,
          fontSize: 7.sp,
        ),
        CustomText(
          text: time,
          color: Colors.black,
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class DatePlaced extends StatelessWidget {
  final String date;

  const DatePlaced({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: 'Date Placed',
          color: Colors.grey,
          fontSize: 7.sp,
        ),
        CustomText(
          text: date,
          color: Colors.black,
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class NumberOfPackages extends StatelessWidget {
  final String numberOfPackages;

  const NumberOfPackages({
    Key? key,
    required this.numberOfPackages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'No of packages',
          color: Colors.grey,
          fontSize: 7.sp,
        ),
        CustomText(
          text: numberOfPackages,
          color: Colors.black,
          fontSize: 8.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
