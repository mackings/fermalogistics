
import 'package:fama/Views/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StockSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const StockSearchTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.arrow_back_ios, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(Icons.filter_list, color: Colors.grey),
            onPressed: () {

            },
          ),
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
        style: GoogleFonts.montserrat(),
        onChanged: (value) {
          if (value.isNotEmpty) {
           
          }
        },
      ),
    );
  }
}
