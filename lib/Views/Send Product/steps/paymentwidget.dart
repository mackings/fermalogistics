import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';


class PaymentMethodContainer extends StatelessWidget {
  
  final String svgPath;
  final String paymentMethod;
  final bool isSelected;
  final ValueChanged<bool?>? onSelected;

  const PaymentMethodContainer({
    required this.svgPath,
    required this.paymentMethod,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              svgPath,
              width: 40,  
              height: 40,
            ),
          ),

          SizedBox(width: 16),

          Expanded(
            child: CustomText(
              text: paymentMethod,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          Radio<bool>(
            value: true,
            groupValue: isSelected,
            onChanged: onSelected,
          ),

        ],
      ),
    );
  }
}
