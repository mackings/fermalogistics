import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ContactInfoCard extends StatelessWidget {
  final String name;
  final String role;

  const ContactInfoCard({Key? key, required this.name, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: btngrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: CustomText(
            text: name,
            fontWeight: FontWeight.w600,
          ),
          subtitle: CustomText(
            text: role,
            color: Colors.grey,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.call, color: Colors.white),
              ),
              SizedBox(width: 2.w),
              CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.email, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
