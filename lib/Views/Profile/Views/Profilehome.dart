import 'package:fama/Views/Profile/Widgets/balcard.dart';
import 'package:flutter/material.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            
        SizedBox(height: 30,),

            BalanceCard(
          balance: 2000,
          onTopUp: () {
        
          },
        ),
        
        
        
          ],
        ),
      ),
    );
  }
}