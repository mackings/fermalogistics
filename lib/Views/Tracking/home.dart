import 'package:fama/Views/Tracking/Scancode.dart';
import 'package:fama/Views/Tracking/widgets/searchcard.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SearchHome extends ConsumerStatefulWidget {
  const SearchHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchHomeState();
}

class _SearchHomeState extends ConsumerState<SearchHome> {
  TextEditingController Search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: '',
              hintText: 'Enter Tracking Number',
              controller: Search,
              onChanged: (value) {},
              suffix: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanCode()));
                  },
                  child: Icon(Icons.qr_code_scanner)),
            ),
            SizedBox(height: 20.0),
            
            Flexible(child: SearchCard()),
          ],
        ),
      ),
    );
  }
}
