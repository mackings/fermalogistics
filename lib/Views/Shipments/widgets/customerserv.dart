import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart'; 

class CustomerService extends StatelessWidget {
  final String name;
  final String title;
  final void Function()? onCallPressed;
  final void Function()? onEmailPressed;

  const CustomerService({
    Key? key,
    required this.name,
    required this.title,
    this.onCallPressed,
    this.onEmailPressed,
  }) : super(key: key);

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
            text: title,
            color: Colors.grey,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onCallPressed,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              GestureDetector(
                onTap: onEmailPressed,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
