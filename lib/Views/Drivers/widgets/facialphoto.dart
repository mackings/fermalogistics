// import 'dart:io';

// import 'package:fama/Views/widgets/button.dart';
// import 'package:flutter/material.dart';

// class FacialVerificationWidget extends StatelessWidget {

//   final VoidCallback onTakePhoto;
//   final VoidCallback onRetakePhoto;
//   final String? uploadedImagePath;

//   const FacialVerificationWidget({
//     Key? key,
//     required this.onTakePhoto,
//     required this.onRetakePhoto,
//     this.uploadedImagePath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title and Instructions
//           Text(
//             "Facial Verification",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             "1. You must replicate the exact pose of the sample picture.\n"
//             "2. Your face must be clearly visible (no glasses, shades).",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//           ),
//           SizedBox(height: 16),

//           // Sample and Uploaded Photos
//           Row(
//             children: [
//               // Sample Image
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 150,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8),
//                         image: DecorationImage(
//                           image: AssetImage('assets/sample_photo.jpg'), // Replace with your sample image
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Sample Photo",
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 16),

//               // User Photo or Placeholder
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 150,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8),
//                         color: Colors.grey[200],
//                       ),
//                       child: uploadedImagePath == null
//                           ? Center(
//                               child: Icon(
//                                 Icons.add_photo_alternate_outlined,
//                                 size: 40,
//                                 color: Colors.grey,
//                               ),
//                             )
//                           : ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.file(
//                                 File(uploadedImagePath!),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Your Photo",
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),

//           // Note
//           Text(
//             "⚠️ It will be visible on your profile",
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: 16),

//           // Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: onTakePhoto,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text("Take Photo"),
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: onRetakePhoto,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red.withOpacity(0.5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text("Take a new photo"),
//                 ),
//               ),
//             ],
//           ),


//            CustomButton(
//               text: 'Continue',
//               onPressed: () {
//                 widget.onComplete({
//                   'paymentMethod': selectedMethod, 
//                 });
//               },
//             )
//         ],
//       ),
//     );
//   }
// }
