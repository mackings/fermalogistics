import 'dart:convert';

import 'package:getnamibia/Views/Profile/Api/Apiservice.dart';
import 'package:getnamibia/Views/Profile/Widgets/Notificationcard.dart';
import 'package:getnamibia/Views/Profile/Widgets/balcard.dart';
import 'package:getnamibia/Views/Profile/model/transactions.dart';
import 'package:getnamibia/Views/Profile/model/usermodel.dart';
import 'package:getnamibia/Views/Topup/views/topup.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';




class WalletHome extends StatefulWidget {
  const WalletHome({super.key});

  @override
  State<WalletHome> createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  UserData? userData;
  List<Transaction> transactions = []; // List to hold the transactions
  bool isLoading = true; // Loading state

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

  Future<void> _loadTransactions() async {
    ApiService apiService = ApiService();
    final response = await apiService.fetchTransactions();

    if (response != null && response.status == "success") {
      setState(() {
        transactions = response.transactions!;
        print(response.transactions);
      });
    }
    setState(() {
      isLoading = false; // Update loading state
    });
  }

  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat('MMMM dd, yyyy, hh:mm a').format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadTransactions(); // Load transactions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Wallet"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TopUp()));
                },
                child: BalanceCard(
                  balance: userData?.safeWallet?.toString() ??
                      '0.00', // Ensure a default value
                  onTopUp: () {},
                ),
              ),
              SizedBox(height: 30),
              isLoading // Show loading indicator while fetching data
                  ? CircularProgressIndicator()
                  : transactions.isEmpty // Check if transactions list is empty
                      ? Text(
                          "No transactions available.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : Column(
                          children: transactions.map((transaction) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NotificationCard(
                                icon: Icons.arrow_upward,
                                iconColor: Colors.red,
                                backgroundColor: Colors.red.shade50,
                                title:
                                    "Transaction with ${transaction.senderName}",
                                message: "\$${transaction.amount}",
                                timestamp: formatTimestamp(
                                    transaction.createdAt.toString()),
                              ),
                            );
                          }).toList(),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
//adb connect 192.168.43.163:5555 