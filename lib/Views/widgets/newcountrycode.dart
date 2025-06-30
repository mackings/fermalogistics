import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Newcountrycode extends StatelessWidget {

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final String selectedCountryCode;
  final Function(String) onCountryCodeChanged;
  final Function(String) onCountryNameChanged;

  const Newcountrycode({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.selectedCountryCode,
    required this.onCountryCodeChanged,
    required this.onCountryNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: GoogleFonts.inter(fontSize: 12.sp)),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        final dialCode = '+${country.phoneCode}';
                        final countryName = country.name;

                        // Callbacks
                        onCountryCodeChanged(dialCode);
                        onCountryNameChanged(countryName);

                        debugPrint('Selected: $countryName ($dialCode)');
                        print('Phone Code: ${country.phoneCode}');
                        print('Country Name: ${country.name}');
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        selectedCountryCode,
                        style: GoogleFonts.inter(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 13,
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.inter(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
