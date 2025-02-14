
import 'package:fama/Views/Stock/Views/Cart/Pages/qoute.dart';
import 'package:fama/Views/Stock/Views/Cart/Widgets/cartwidget.dart';
import 'package:fama/Views/Stock/Widgets/Payments/payment.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';





class ShippingCheckout extends StatefulWidget {
  final ShippingOption selectedShipping;
  final double shippingCost;
  final String
      shippingType; // Add this to store the shipping type (e.g., "cargo", "express")
  final String
      shippingDuration; // Add this to store the shipping duration (e.g., "3-5 days")

  const ShippingCheckout({
    Key? key,
    required this.selectedShipping,
    required this.shippingCost,
    required this.shippingType,
    required this.shippingDuration,
  }) : super(key: key);

  @override
  State<ShippingCheckout> createState() => _ShippingCheckoutState();
}

class _ShippingCheckoutState extends State<ShippingCheckout> {
  ShippingOption selectedShipping = ShippingOption.cargo;
  double shippingCost = 0.0;
  String shippingType = ''; // Store the shipping type
  String shippingDuration = ''; // Store the shipping duration
  double discount = 10.0; // Example discount amount
  List<Map<String, dynamic>> cartItems = [];
  String shippingAddress = '';

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    _loadShippingAddress();

    selectedShipping = widget.selectedShipping;
    shippingCost = widget.shippingCost;
    shippingType = widget.shippingType;
    shippingDuration = widget.shippingDuration;

    print("Received in Checkout - Type: $shippingType, Cost: $shippingCost");
  }

  Future<void> _loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartProductJsonList = prefs.getStringList('cartProducts');

    if (cartProductJsonList != null) {
      setState(() {
        cartItems = cartProductJsonList
            .map((productJson) =>
                jsonDecode(productJson) as Map<String, dynamic>)
            .toList();
      });
    }
  }

  Future<void> _loadShippingAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString('shipping_address'); // Load the address

    if (address != null) {
      setState(() {
        shippingAddress = address; // Set the address to the variable
      });
    }
  }

  double _calculateTotalPrice() {
    double cartTotal = cartItems.fold(0, (total, item) {
      return total + (item['price'] * item['quantity']);
    });
    return cartTotal + shippingCost - discount;
  }

  void _removeItem(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItems.removeAt(index);
    });
    List<String> updatedCart =
        cartItems.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('cartProducts', updatedCart);
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index]['quantity'] = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: List.generate(cartItems.length, (index) {
                final item = cartItems[index];
                return Column(
                  children: [
                    CartProductWidget(
                      productName: item['productName'],
                      productImage: item['productImages'][0],
                      price: item['price'],
                      quantity: item['quantity'],
                      onDelete: () => _removeItem(index),
                      onQuantityChange: (newQuantity) =>
                          _updateQuantity(index, newQuantity),
                    ),
                    if (index < cartItems.length - 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                  ],
                );
              }),
            ),
            SizedBox(height: 10),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                  text: "Shipping Type", fontWeight: FontWeight.bold),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFFFEFF0),
                  child: selectedShipping == ShippingOption.cargo
                      ? SvgPicture.asset('assets/ship.svg')
                      : SvgPicture.asset('assets/plane.svg'),
                ),
                title: CustomText(
                  text: shippingType, // Use the dynamic shipping type
                ),
                subtitle: CustomText(
                  text: shippingDuration, // Use the dynamic shipping duration
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text:
                          "\$${shippingCost.toStringAsFixed(2)}", // Use the dynamic shipping cost
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                  text: "Shipping Address", fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.red),
                title: CustomText(
                    text: shippingAddress.isNotEmpty
                        ? shippingAddress
                        : "No address selected"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  _buildPriceRow('Amount:',
                      '\$${_calculateTotalPrice().toStringAsFixed(2)}'),
                  _buildPriceRow(
                      'Shipping:', '\$${shippingCost.toStringAsFixed(2)}'),
                  _buildPriceRow(
                      'Discount:', '- \$${discount.toStringAsFixed(2)}'),
                  Divider(thickness: 2),
                  _buildPriceRow('Total:',
                      '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                      isTotal: true),
                ],
              ),
            ),

            SizedBox(height: 20),

            CustomButton(
  text: 'Continue to Payment',
  onPressed: () {
    // Prepare cart data (product ID & quantity)
    List<Map<String, dynamic>> cartData = cartItems.map((item) {
      return {
        'productId': item['id'],
        'quantity': item['quantity']
      };
    }).toList();

    // Navigate to CheckoutPayment and pass cart items & shipping address
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPayment(
          cartItems: cartData,  
          shippingAddress: shippingAddress,  // Pass the selected location
           shippingMethod: selectedShipping,
          onComplete: (value) {},
        ),
      ),
    );
  },
),


            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }



  // Helper method to build price rows
  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
          CustomText(
            text: amount,
            color: isTotal ? Colors.green : Colors.black,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
