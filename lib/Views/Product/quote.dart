import 'dart:convert';
import 'package:fama/Views/Product/Api/apiclass.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;



class Getquote extends ConsumerStatefulWidget {
  const Getquote({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetquoteState();
}

class _GetquoteState extends ConsumerState<Getquote> {

  
  dynamic userToken;
  bool isLoading = false;

  // Controllers for additional fields
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  TextEditingController sender = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController noofpackage = TextEditingController();

  Future<void> _retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      setState(() {
        userToken = userData['token'];
      });
    }
    print(userToken);
  }

  @override
  void initState() {
    _retrieveUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Get a Quote'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              CustomTextFormField(
                  labelText: 'From *',
                  hintText: 'Send location',
                  controller: sender,
                  suffix: Image.asset('assets/location.png'),
                  onChanged: (value) {}),
              SizedBox(height: 2.h),
              CustomTextFormField(
                  labelText: 'Destination *',
                  hintText: 'Send location',
                  controller: destination,
                  suffix: Image.asset('assets/location.png'),
                  onChanged: (value) {}),
              SizedBox(height: 2.h),
              CustomTextFormField(
                  labelText: 'Weight of Package *',
                  hintText: '1',
                  controller: weight,
                  onChanged: (value) {}),
              SizedBox(height: 2.h),
              CustomTextFormField(
                  labelText: 'Quantity *',
                  hintText: '1',
                  controller: noofpackage,
                  onChanged: (value) {}),
              SizedBox(height: 2.h),
              CustomTextFormField(
                  labelText: 'Height *',
                  hintText: '2',
                  controller: heightController,
                  onChanged: (value) {}),
              SizedBox(height: 2.h),
              CustomTextFormField(
                  labelText: 'Width *',
                  hintText: '3',
                  controller: widthController,
                  onChanged: (value) {}),
              SizedBox(height: 2.h),
              CustomTextFormField(
                  labelText: 'Length *',
                  hintText: '2.4',
                  controller: lengthController,
                  onChanged: (value) {}),
              SizedBox(height: 2.h),

CustomTextFormField(
  labelText: 'Rates *',
  hintText: 'Express',
  controller: rateController,
  onChanged: (value) {},
  inputFormatters: [
    TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;
      return newValue.copyWith(
        text: text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : '',
        selection: newValue.selection,
      );
      
    }),
  ],
),

              SizedBox(height: 5.h),

              isLoading
                  ? CircularProgressIndicator(color: btncolor,) // Display a loading spinner
                  : CustomButton(
                      text: 'Get a Quote',
                      onPressed: () async {
                        setState(() {
                          isLoading = true; // Start loading
                        });

                        try {
                          var apiService = QuoteApiService();
                          var response = await apiService.createQuote(
                            fromLocation: sender.text,
                            destination: destination.text,
                            weight: double.parse(weight.text),
                            quantity: int.parse(noofpackage.text),
                            height: double.parse(heightController.text),
                            width: double.parse(widthController.text),
                            length: double.parse(lengthController.text),
                            rates: rateController.text,
                            userToken: userToken, // Pass userToken
                          );

                          if (response['success']) {
showModalBottomSheet(
  backgroundColor: Colors.white,
  isScrollControlled: true,
  context: context,
  builder: (BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
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
          height: 70.h,
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
                SizedBox(height: 3.h),

                // Cargo Rate Section
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
                    trailing: CustomText(
                      text: 'USD ${response['rate'] == 'Cargo' ? response['charges'].toString() : ''}',  // Show Cargo charge if rate is 'Cargo'
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 3.h),

                // Express Rate Section
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
                    trailing: CustomText(
                      text: 'USD ${response['rate'] == 'Express' ? response['charges'].toString() : ''}',  // Show Express charge if rate is 'Express'
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 6.h),

                // Back to Home Button
                CustomButton(
                  text: 'Back to Home',
                  onPressed: () {
                    Navigator.pop(context);  // Close the modal
                  },
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  },
);


                          } else {
                            print('Failed to create quote');
                          }
                        } catch (e) {
                          print('Error: $e');
                        } finally {
                          setState(() {
                            isLoading = false; // Stop loading
                          });
                        }
                      },
                    ),

              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}

