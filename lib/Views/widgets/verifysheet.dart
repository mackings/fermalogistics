import 'package:flutter/material.dart';
import 'package:getnamibia/Views/Auth/verify.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';


class VerifyAccountBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info_outline, size: 40, color: Colors.orange),
              const SizedBox(height: 10),
              CustomText(text: "Your Account is Pending verification"),
              const SizedBox(height: 15),

              CustomButton(
                text: 'Verify Now', 
                onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Verification()),
                    );
                }

                ),
            ],
          ),
        );
      },
    );
  }
}
