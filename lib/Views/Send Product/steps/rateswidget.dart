import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class RatesModal extends StatelessWidget {
  final String pickupLocation;
  final String destinationLocation;
  final String cargoPrice;
  final String expressPrice;
  final Function(String title, String price) onRateSelected;

  const RatesModal({
    required this.pickupLocation,
    required this.destinationLocation,
    required this.cargoPrice,
    required this.expressPrice,
    required this.onRateSelected,
  });

  @override
  Widget build(BuildContext context) {
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
                          text: pickupLocation,
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
                          text: destinationLocation,
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
                buildRateItem(
                  context,
                  icon: 'assets/ship.svg',
                  title: 'Cargo',
                  duration: '3-5 days',
                  price: cargoPrice,
                ),
                SizedBox(height: 3.h),
                buildRateItem(
                  context,
                  icon: 'assets/plane.svg',
                  title: 'Express',
                  duration: '1-2 days',
                  price: expressPrice,
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
  }

  Widget buildRateItem(BuildContext context, {
    required String icon,
    required String title,
    required String duration,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        onRateSelected(title, price);
      },
      child: Container(
        height: 10.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: btngrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFFFEFF0),
            child: SvgPicture.asset(icon),
          ),
          title: CustomText(
            text: title,
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
          ),
          subtitle: CustomText(
            text: duration,
            color: const Color.fromARGB(255, 226, 217, 217),
          ),
          trailing: CustomText(
            text: price,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// To show the modal bottom sheet, you can call the following function:
void showRatesModal(
    BuildContext context, {
      required String pickupLocation,
      required String destinationLocation,
      required String cargoPrice,
      required String expressPrice,
      required Function(String title, String price) onRateSelected,
    }) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select Rate'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Cargo'),
              subtitle: Text('Price: $cargoPrice'),
              onTap: () => onRateSelected('Cargo', cargoPrice),
            ),
            ListTile(
              title: Text('Express'),
              subtitle: Text('Price: $expressPrice'),
              onTap: () => onRateSelected('Express', expressPrice),
            ),
          ],
        ),
      );
    },
  );
}

