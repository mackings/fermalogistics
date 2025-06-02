import 'dart:convert';
import 'package:getnamibia/Views/Profile/model/usermodel.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  UserData? userData;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    print(userDataString);

    if (userDataString != null) {
      Map<String, dynamic> userJson = json.decode(userDataString)['user'];
      userData = UserData.fromJson(userJson);

      // Set the values in controllers
      nameController.text = userData?.fullName ?? '';
      emailController.text = userData?.email ?? '';
      phoneController.text = userData?.phoneNumber.toString() ?? '';
      countryController.text = userData?.country ?? '';
      walletController.text = userData?.wallet.toString() ?? '';
      referralCodeController.text = userData?.referralCode ?? '';

      setState(() {}); // Update UI
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: userData?.picture != null
                    ? NetworkImage(userData!.picture.toString())
                    : const AssetImage('assets/default_avatar.png')
                        as ImageProvider, // Placeholder image
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Full Name",
                hintText: "Mac kingsley",
                controller: nameController,
                onChanged: (value) {
                  // Handle changes
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Email",
                hintText: "macsonline500@gmail.com",
                controller: emailController,
                onChanged: (value) {
                  // Handle changes
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Phone Number",
                hintText: "2348110947817",
                controller: phoneController,
                onChanged: (value) {
                  // Handle changes
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Location",
                hintText: "Nigeria",
                controller: countryController,
                onChanged: (value) {
                  // Handle changes
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Wallet Balance",
                hintText: "1999999375.4572518",
                controller: walletController,
                onChanged: (value) {
                  // Handle changes
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                labelText: "Referral Code",
                hintText: "a16cc772",
                controller: referralCodeController,
                onChanged: (value) {
                  // Handle changes
                },
              ),

               const SizedBox(height: 30),

              CustomButton(text: "Update profile", onPressed: (){}),

               const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
