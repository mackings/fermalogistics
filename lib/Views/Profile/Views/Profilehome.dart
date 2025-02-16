import 'package:fama/Views/Auth/Pin/Createpin.dart';
import 'package:fama/Views/Drivers/DriverHome.dart';
import 'package:fama/Views/Profile/Views/Update/profileupdate.dart';
import 'package:fama/Views/Profile/Views/Wallet/wallethome.dart';
import 'package:fama/Views/Profile/Widgets/balcard.dart';
import 'package:fama/Views/Profile/Widgets/profiletile.dart';
import 'package:fama/Views/Profile/model/usermodel.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';




class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  UserData? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    print(userDataString);

    if (userDataString != null) {
      Map<String, dynamic> userJson = json.decode(userDataString)['user'];
      userData = UserData.fromJson(userJson);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if (userData != null) ...[
                Container(
                  decoration: BoxDecoration(
                      color: btngrey, borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: CustomText(text: "${userData!.fullName}"),
                      subtitle: CustomText(
                        text: "${userData!.email}",
                        color: Colors.grey,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(userData!.picture.toString()),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                BalanceCard(
                  balance: userData!.safeWallet,
                  onTopUp: () {},
                ),
              ] else ...[
                Center(child: CircularProgressIndicator()),
              ],

              SizedBox(height: 20),

              // Standard Profile Options
              ProfileOptionTile(
                icon: Icons.account_balance,
                iconColor: Colors.red,
                backgroundColor: Colors.red.shade50,
                title: "Wallet",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WalletHome()));
                },
              ),
              ProfileOptionTile(
                icon: Icons.lock_outline,
                iconColor: Colors.red,
                backgroundColor: Colors.red.shade50,
                title: "Transaction Pin",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePin()));
                },
              ),
              ProfileOptionTile(
                icon: Icons.person,
                iconColor: Colors.red,
                backgroundColor: Colors.red.shade50,
                title: "Edit Profile",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdate()));
                },
              ),
              ProfileOptionTile(
                icon: Icons.notifications,
                iconColor: Colors.red,
                backgroundColor: Colors.red.shade50,
                title: "Notifications",
                onTap: () {
                  print("Notifications tapped!");
                },
              ),
              ProfileOptionTile(
                icon: Icons.connect_without_contact,
                iconColor: Colors.red,
                backgroundColor: Colors.red.shade50,
                title: "Refer and Earn",
                onTap: () {
                  print("Refer and Earn tapped!");
                },
              ),

              // **Conditional Menu for Delivery Personnel**
              if (userData != null && userData!.roles == "deliveryPersonnel") ...[
                ProfileOptionTile(
                  icon: Icons.verified_user,
                  iconColor: Colors.red,
                  backgroundColor: Colors.red.shade50,
                  title: "Verification",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHome()));
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

