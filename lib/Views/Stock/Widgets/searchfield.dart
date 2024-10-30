import 'package:fama/Views/Stock/Views/Search/search.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const SearchTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: btngrey,
        borderRadius: BorderRadius.circular(10), 
        border: Border.all(color: Colors.grey.shade300), 
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey), 
          hintText: hintText,
          border: InputBorder.none, 
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16), 
        ),
        style: GoogleFonts.montserrat(),
        onChanged: (value) {
          // if (value.isNotEmpty) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => SearchStock()),
          //   );
          // }
        },
         onTap: () {
           Navigator.push(context,
           MaterialPageRoute(builder: (context) => SearchStock()));
        },
      ),
    );
  }
}
