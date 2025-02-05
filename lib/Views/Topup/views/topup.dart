import 'package:fama/Views/Topup/widget/topupcard.dart';
import 'package:fama/Views/Topup/widget/topuppin.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  String _balance = '1000';
  String _topUpAmount = ''; // Store the entered amount here

  void _updateAmount(String amount) {
    setState(() {
      _topUpAmount =
          amount; 
      print(_topUpAmount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Top Up", fontWeight: FontWeight.w700),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TopUpCard(
            balance: _balance,
            onTopUp: () {
              setState(() {
                // Handle Top Up action if needed
              });
            },
          ),

          TopUpPin(
            onAmountUpdated: _updateAmount, 
          ),

        ],
      ),
    );
  }
}
