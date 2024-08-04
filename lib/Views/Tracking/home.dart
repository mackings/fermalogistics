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
              suffix: Icon(Icons.qr_code_scanner),
            ),
            SizedBox(height: 20.0), // Replace with SizedBox(height: 2.h) if using a responsive layout package
            Flexible(child: SearchCard()),
          ],
        ),
      ),
    );
  }
}


// Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20,right: 20),
//         child: Column(
//           children: [
//             CustomTextFormField(
//                 labelText: '',
//                 hintText: 'Enter Tracking Number',
//                 controller: Search,
//                 onChanged: (value){},
//                 suffix: Icon(Icons.qr_code_scanner),
//                 ),
//                 SizedBox(height: 2.h,),

//                 SearchCard(),
//           ],
//         ),
//       ),
//     );













// import 'package:fama/Views/Tracking/widgets/timeline.dart';
// import 'package:fama/Views/widgets/colors.dart';
// import 'package:fama/Views/widgets/texts.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:timeline_tile/timeline_tile.dart';

// class SearchCard extends StatefulWidget {
//   const SearchCard({super.key});

//   @override
//   State<SearchCard> createState() => _SearchCardState();
// }

// class _SearchCardState extends State<SearchCard> {
//   TextEditingController Search = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
    
//     return Container(
//   height: 30.h,
//   decoration: BoxDecoration(
//     color: btngrey, 
//     borderRadius: BorderRadius.circular(10),
//   ),
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [

//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [

//             CustomText(
//               text: "Tracking ID",
//               fontSize: 12.sp,
//             ),

//             Container(
//               height: 40,
//               width: 90,
//               decoration: BoxDecoration(
//                 color: btncolor, 
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Center(
//                 child: CustomText(
//                   text: 'In Transit',
//                   color: Colors.white,
//                 ),
//               ),
//             )
//           ],
//         ),

//         Align(
//           alignment: Alignment.centerLeft,
//           child: CustomText(text: "LKNVNM"),
//         ),

//         SizedBox(height: 1.h),

//             Flexible(
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   // Calculate the width factor based on screen width
//                   double widthFactor = constraints.maxWidth < 600 ? 1.3 : 1.6;

//                   // Calculate padding based on screen width
//                   double horizontalPadding = constraints.maxWidth < 600 ? 10.0 : 40.0;

//                   return FractionallySizedBox(
//                     widthFactor: widthFactor,
//                     heightFactor: 0.3,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TimelineTile(
//                             axis: TimelineAxis.horizontal,
//                             isFirst: true,
//                           ),
//                           TimelineTile(
//                             axis: TimelineAxis.horizontal,
//                             isFirst: false,
//                           ),
//                           TimelineTile(
//                             axis: TimelineAxis.horizontal,
//                             isFirst: false,
//                           ),
//                           TimelineTile(
//                             axis: TimelineAxis.horizontal,
//                             isLast: true,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//         CustomText(text: 'Yooo')
//       ],
//     ),
//   ),
// );

//   }
// }
