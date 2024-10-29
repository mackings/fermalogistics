import 'package:fama/Views/Send%20Product/steps/paymentwidget.dart';
import 'package:fama/Views/Send%20Product/steps/step4.dart';
import 'package:fama/Views/Stock/Views/Cart/Pages/qoute.dart';
import 'package:fama/Views/Stock/Views/Cart/Widgets/cartwidget.dart';
import 'package:fama/Views/Stock/Widgets/Payments/payment.dart';
import 'package:fama/Views/Stock/Widgets/widgetviews/modal.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShippingCheckout extends StatefulWidget {
  const ShippingCheckout({super.key});

  @override
  State<ShippingCheckout> createState() => _ShippingCheckoutState();
}

class _ShippingCheckoutState extends State<ShippingCheckout> {
  ShippingOption selectedShipping = ShippingOption.cargo;
  double discount = 10.0; // Example discount amount
  double shippingCost = 30.0; // Default shipping cost
  List<Map<String, dynamic>> cartItems = [];
  String shippingAddress = ''; // Variable to store the shipping address

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    _loadShippingAddress(); // Load the shipping address on initialization
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
                  text: selectedShipping == ShippingOption.cargo
                      ? 'Cargo'
                      : 'Express',
                ),
                subtitle: CustomText(
                  text: selectedShipping == ShippingOption.cargo
                      ? '3-5 days'
                      : '1-2 days',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: selectedShipping == ShippingOption.cargo
                          ? "\$30"
                          : "\$400",
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ShippingQuoteModal(
                              initialSelection: selectedShipping,
                              onSelectionChanged:
                                  (ShippingOption newSelection) {
                                setState(() {
                                  selectedShipping = newSelection;
                                  shippingCost =
                                      newSelection == ShippingOption.cargo
                                          ? 30.0
                                          : 400.0;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
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

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => 
                        CheckoutPayment(onComplete: (value){})
               ));

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
