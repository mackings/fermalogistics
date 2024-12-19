
import 'package:fama/Views/Send%20Product/steps/paymentwidget.dart';
import 'package:fama/Views/Stock/Widgets/Payments/Pinwidgets.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class CheckoutPayment extends StatefulWidget {

  final void Function(Map<String, dynamic> data) onComplete;

  const CheckoutPayment({required this.onComplete, Key? key}) : super(key: key);

  @override
  State<CheckoutPayment> createState() => _CheckoutPaymentState();
}

class _CheckoutPaymentState extends State<CheckoutPayment> {
  TextEditingController senderName = TextEditingController();
  TextEditingController senderPhone = TextEditingController();
  TextEditingController pickupAddress = TextEditingController();
  TextEditingController pickupEmail = TextEditingController();

  String selectedMethod = '';

  void onPaymentMethodSelected(String method) {
    setState(() {
      selectedMethod = method;
      print(selectedMethod);
    });
  }


  void _showPinInputModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: CartPinInputModal(id: '',),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Payment Method"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text: "Payment Method",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: "Kindly select your preferred payment method ",
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 5.h,
                ),
        
                PaymentMethodContainer(
                  paymentMethod: 'My Wallet',
                  isSelected: selectedMethod == 'My Wallet',
                  onSelected: (value) {
                    onPaymentMethodSelected('My Wallet');
                  },
                  svgPath: 'assets/wallet.svg',
                ),
        
                PaymentMethodContainer(
                  paymentMethod: 'Cash on pickup',
                  isSelected: selectedMethod == 'Cash on pickup',
                  onSelected: (value) {
                    onPaymentMethodSelected('Cash on pickup');
                  },
                  svgPath: 'assets/cash.svg',
                ),
        
                PaymentMethodContainer(
                  paymentMethod: 'Paypal',
                  isSelected: selectedMethod == 'Paypal',
                  onSelected: (value) {
                    onPaymentMethodSelected('Paypal');
                  },
                  svgPath: 'assets/paypal.svg',
                ),
        
                PaymentMethodContainer(
                  paymentMethod: 'GooglePay',
                  isSelected: selectedMethod == 'GooglePay',
                  onSelected: (value) {
                    onPaymentMethodSelected('GooglePay');
                  },
                  svgPath: 'assets/GooglePay.svg',
                ),
        
                SizedBox(
                  height: 7.h,
                ),
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    _showPinInputModal(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
