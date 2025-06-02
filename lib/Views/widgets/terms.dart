import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final Color buttonColor;
  final Function()? onPressed;

  const TermsAndConditionsWidget({
    Key? key,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: true, // You can set the initial value of the checkbox here
          onChanged: (_) {}, // You can handle the onChanged event here
          activeColor: buttonColor, // Use the buttonColor for the checkbox color
        ),
        CustomText(
          text: 'I agree to the',
          color: Colors.black, // Set the color of the first text
        ),
        TextButton(
          onPressed: onPressed,
          child: CustomText(
            text: 'Terms and Conditions',
            color: buttonColor, // Use the buttonColor for the text color
          ),
        ),
      ],
    );
  }
}


class AlreadyHaveAccountWidget extends StatelessWidget {
  final Color buttonColor;
  final Function()? onLoginPressed;

  const AlreadyHaveAccountWidget({
    Key? key,
    required this.buttonColor,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: 'Already have an account? ',
          color: Colors.black, 
        ),
        TextButton(
          onPressed: onLoginPressed,
          child: CustomText(
            text: 'Login',
            fontWeight: FontWeight.w600,
            color: buttonColor, 
          ),
        ),
      ],
    );
  }
}
