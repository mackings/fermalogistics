import 'package:fama/Views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SuccessModal extends StatelessWidget {
  final String title;
  final String subtitle;

  SuccessModal(
      {this.title = "You did it",
      this.subtitle =
          "Documents uploaded are on review and approval will be sent via mail"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.h,),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 90.0,
                ),

                SizedBox(height: 10.h,),

                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h,),

                CustomButton(
                    text: "Continue",
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Function to call the bottom sheet with the success modal
void showSuccessModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SuccessModal();
    },
  );
}
