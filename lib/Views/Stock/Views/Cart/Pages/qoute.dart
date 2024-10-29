import 'package:fama/Views/Stock/Views/checkout/checkout.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

enum ShippingOption { cargo, express }

class ShippingQuote extends StatefulWidget {
  const ShippingQuote({super.key, ShippingOption? initialSelection, required Null Function(ShippingOption newSelection) onSelectionChanged});

  @override
  State<ShippingQuote> createState() => _ShippingQuoteState();
}

class _ShippingQuoteState extends State<ShippingQuote> {
  ShippingOption? selectedShipping = ShippingOption.cargo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Shipping Quote"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          children: [
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: "\$700",
                      fontWeight: FontWeight.w600,
                    ),
                    Radio<ShippingOption>(
                      value: ShippingOption.cargo,
                      groupValue: selectedShipping,
                      onChanged: (ShippingOption? value) {
                        setState(() {
                          selectedShipping = value;
                        });
                      },
                    ),
                  ],
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: "\$400",
                      fontWeight: FontWeight.w600,
                    ),
                    Radio<ShippingOption>(
                      value: ShippingOption.express,
                      groupValue: selectedShipping,
                      onChanged: (ShippingOption? value) {
                        setState(() {
                          selectedShipping = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 48.h),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                print(selectedShipping);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShippingCheckout())
                        );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
