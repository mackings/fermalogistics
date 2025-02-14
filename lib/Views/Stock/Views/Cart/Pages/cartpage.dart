import 'dart:convert';
import 'package:fama/Views/Stock/Views/Cart/Pages/shippingaddress.dart';
import 'package:fama/Views/Stock/Views/Cart/Widgets/cartwidget.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';




class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
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

  double _calculateTotalPrice() {
    return cartItems.fold(0, (total, item) {
      return total + (item['price'] * item['quantity']);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index]['quantity'] = newQuantity;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text:"Cart Page")),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartProductWidget(
                              productName: item['productName'],
                              productImage: item['productImages'][0],
                              price: item['price'],
                              quantity: item['quantity'],
                              onDelete: () => _removeItem(index),
                              onQuantityChange: (newQuantity) =>
                                  _updateQuantity(index, newQuantity),
                            ),
                          ),
                          if (index < cartItems.length - 1)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(thickness: 1, color: Colors.grey),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total price',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                            style: GoogleFonts.montserrat(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartAddress(cartItems: cartItems),
      ),
    );
  },
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        'Checkout',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  ),
),

                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
