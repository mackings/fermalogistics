import 'dart:async';

import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class VerificationWidget extends StatefulWidget {
  @override
  _VerificationWidgetState createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {



    late Timer _timer;
  int _start = 120; // 2 minutes in seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get timerText {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  List<String> inputValues = ['', '', '', ''];
  int currentIndex = 0;

  void onNumberPressed(String number) {
    setState(() {
      if (currentIndex < 4) {
        inputValues[currentIndex] = number;
        currentIndex++;
      }
    });
  }

  void onClearPressed() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        inputValues[currentIndex] = '';
      }
    });
  }


  Widget buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => onNumberPressed(number),
      child: Container(
        margin: EdgeInsets.all(2.w),
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:  Color(0xFFF3F3F3),
        ),
        child: Center(
          child: Text(
            number,
            style: GoogleFonts.inter(
              color: Color(0xFF808080),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  inputValues[index],
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: 'Didnt Get an OTP?'),
              SizedBox(width: 1.w,),
              CustomText(
                text: 'Resend In $timerText s',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          ),
        ),

        SizedBox(height: 3.h),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('1'),
                buildNumberButton('2'),
                buildNumberButton('3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('4'),
                buildNumberButton('5'),
                buildNumberButton('6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton('7'),
                buildNumberButton('8'),
                buildNumberButton('9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNumberButton2(''),
                buildNumberButton('0'),
                GestureDetector(
                  onTap: onClearPressed,
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    width: 15.w,
                    height: 15.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF3F3F3),
                    ),
                    child: Center(
                      child: Icon(Icons.clear_all_sharp)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}



class VerificationInfoWidget extends StatelessWidget {
  final String email;

  VerificationInfoWidget({required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verify your Email',
            style: GoogleFonts.inter(
              color: Color(0xFF121212),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Please enter the 6-digit OTP sent to your \nemail ',
                  style: GoogleFonts.inter(
                    color: Color(0xFF808080),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: email,
                  style: GoogleFonts.inter(
                    color: Color(0xFF121212),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




  Widget buildNumberButton2(String number) {
    return GestureDetector(
      onTap: () => onNumberPressed(number),
      child: Container(
        margin: EdgeInsets.all(2.w),
        width: 15.w,
        height: 15.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Center(
          child: Text(
            number,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  onNumberPressed(String number) {
  }
