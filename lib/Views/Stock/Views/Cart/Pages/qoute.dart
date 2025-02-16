import 'dart:convert';
import 'package:fama/Views/Stock/Views/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/svg.dart';





enum ShippingOption { cargo, express, regular }

class ShippingQuote extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String shippingAddress;

  const ShippingQuote({
    Key? key,
    required this.cartItems,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  State<ShippingQuote> createState() => _ShippingQuoteState();
}

class _ShippingQuoteState extends State<ShippingQuote> {
  ShippingOption? selectedShipping = ShippingOption.cargo;
  Map<String, dynamic>? shippingCosts;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchShippingCosts();
  }

  Future<void> fetchShippingCosts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      String? token = await retrieveUserData();
      if (token == null) {
        setState(() {
          errorMessage = "Authentication failed. Please log in.";
          isLoading = false;
        });
        return;
      }

      final response = await http.post(
        Uri.parse(
            "https://fama-logistics.onrender.com/api/v1/checkout/calculateShipmentCostForOrder"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "cartItems": widget.cartItems.map((item) {
            return {
              "productId": item["id"],
              "quantity": item["quantity"],
            };
          }).toList(),
          "shippingAddress": widget.shippingAddress,
        }),
      );

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  setState(() {
    shippingCosts = data["summary"]["shippingCosts"];
    isLoading = false;
  });
  print("Shipping Costs Map: $shippingCosts");  // Debugging
} else {
  setState(() {
    errorMessage = "Failed to fetch shipping costs.";
    isLoading = false;
  });
}

    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
        isLoading = false;
      });
    }
  }

  Future<String?> retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Shipping Quote"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : errorMessage != null
                ? Center(
                    child: CustomText(text: errorMessage!, color: Colors.red))
                : Column(
                    children: [
                      buildShippingOption(
                        title: 'Cargo',
                        subtitle: '3-5 days',
                        cost: shippingCosts?["Cargo"],
                        icon: 'assets/ship.svg',
                        option: ShippingOption.cargo,
                      ),
                      SizedBox(height: 3.h),

                      buildShippingOption(
                        title: 'Express',
                        subtitle: '1-2 days',
                        cost: shippingCosts?["Express"],
                        icon: 'assets/plane.svg',
                        option: ShippingOption.express,
                      ),
                      SizedBox(height: 3.h),

                      buildShippingOption(
                        title: 'Regular',
                        subtitle: '5-7 days',
                        cost: shippingCosts?["Regular"],
                        icon:
                            'assets/track.svg', // Update the asset path accordingly
                        option: ShippingOption.regular,
                      ),

                      SizedBox(height: 35.h),

CustomButton(
  text: 'Continue',
onPressed: () {
  if (shippingCosts == null || selectedShipping == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shipping costs are not loaded yet')),
    );
    return;
  }

  // Convert enum name to match API key (e.g., "cargo" -> "Cargo")
  String selectedKey = selectedShipping!.name[0].toUpperCase() + selectedShipping!.name.substring(1);
  double cost = (shippingCosts?[selectedKey] != null)
      ? (shippingCosts![selectedKey] as num).toDouble()
      : 0.0;

  print("Selected Shipping: $selectedShipping, Cost: $cost");

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ShippingCheckout(
        selectedShipping: selectedShipping!,
        shippingCost: cost,
        shippingType: selectedKey,
        shippingDuration: selectedShipping == ShippingOption.cargo
            ? '3-5 days'
            : selectedShipping == ShippingOption.express
                ? '1-2 days'
                : '5-7 days',
      ),
    ),
  );
},

),

                      SizedBox(height: 2.h),
                    ],
                  ),
      ),
    );
  }

  Widget buildShippingOption({
    required String title,
    required String subtitle,
    required int? cost,
    required String icon,
    required ShippingOption option,
  }) {
    return Container(
      height: 10.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: btngrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFFEFF0),
          child: SvgPicture.asset(icon),
        ),
        title: CustomText(
          text: title,
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
        ),
        subtitle: CustomText(
          text: subtitle,
          color: const Color.fromARGB(255, 226, 217, 217),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: cost != null ? "\$${cost.toString()}" : "N/A",
              fontWeight: FontWeight.w600,
            ),
            Radio<ShippingOption>(
              value: option,
              groupValue: selectedShipping,
              onChanged: (ShippingOption? value) {
                setState(() {
                  selectedShipping = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
