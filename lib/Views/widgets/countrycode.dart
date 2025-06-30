import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:country_picker/country_picker.dart';

// class CountryCodeTextFormField extends StatelessWidget {
//   final String labelText;
//   final String hintText;
//   final TextEditingController controller;
//   final Function(String) onChanged;
//   final List<String> countryCodes;
//   final String selectedCountryCode;

//   CountryCodeTextFormField({
//     required this.labelText,
//     required this.hintText,
//     required this.controller,
//     required this.onChanged,
//     required this.countryCodes,
//     required this.selectedCountryCode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           labelText,
//           style: GoogleFonts.plusJakartaSans(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//         ),

//         SizedBox(height: 8.0),

//         Container(
//           //height: 7.h,
//           padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             children: [

// DropdownButton<String>(
//   value: selectedCountryCode,
//   onChanged: (String? newValue) {},
//   underline: CustomText(text: '') ,
//   items: countryCodes.map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.5.h),
//         child: CustomText(
//           text: value,
//         ),
//       ),
//     );
//   }).toList(),
// ),


//              VerticalDivider(color: Colors.grey),

//               Expanded(
//                 child: TextFormField(
//                   controller: controller,
//                   onChanged: onChanged,
//                   style: GoogleFonts.inter(
//                     fontSize: 14.0,
//                     color: Colors.black,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: hintText,
//                     hintStyle: GoogleFonts.inter(
//                       color: Colors.grey,
//                     ),
//                     border: InputBorder.none, // Remove input borders
//                   ),
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }



class CountryCodeTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String selectedCountryCode;
  final Function(String) onCountryCodeChanged;

  CountryCodeTextFormField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.selectedCountryCode,
    required this.onCountryCodeChanged, 
    required Null Function(dynamic name) onCountryNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      onCountryCodeChanged('+${country.phoneCode}');
                    },
                  );
                },
                child: Row(
                  children: [
                    CustomText(
                      text: selectedCountryCode,
                     //fontWeight: FontWeight.bold,
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              VerticalDivider(color: Colors.grey),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onChanged,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}