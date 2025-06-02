import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leadingIconUrl;
  final String dateTimePlaced;

  const RequestCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIconUrl,
    required this.dateTimePlaced,
  }) : super(key: key);

  String _formatDate(String dateTime) {
    final dateTimeObj = DateTime.parse(dateTime);
    return DateFormat('MMM d, yyyy').format(dateTimeObj); // e.g., "Sept 1, 2024"
  }

  String _formatTime(String dateTime) {
    final dateTimeObj = DateTime.parse(dateTime);
    return DateFormat('h:mm a').format(dateTimeObj); // e.g., "2:00 PM"
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: btngrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 20.h - 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(leadingIconUrl), // Load leading image from URL
                ),
                title: CustomText(
                  text: title,
                  fontWeight: FontWeight.w500,
                ),
                subtitle: Text(subtitle),
                trailing: GestureDetector(
                  onTap: () {
                    // Handle click action here
                    print('Check Status clicked!');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: CustomText(
                      text: 'Check Status',
                      color: Colors.white,
                      fontSize: 7.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.white,),
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
                          text: _formatTime(dateTimePlaced),
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
                          text: _formatDate(dateTimePlaced),
                          color: Colors.black,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
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
