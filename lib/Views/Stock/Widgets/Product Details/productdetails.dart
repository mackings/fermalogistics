
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fama/Views/Stock/Model/allproducts.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  int currentImageIndex = 0;
  bool isLoading = false;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }



Future<void> addToCart() async {
  setState(() {
    isLoading = true;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Decode existing cart products (if any)
  List<String> cartProducts = prefs.getStringList('cartProducts') ?? [];

  // New product details
  Map<String, dynamic> productDetails = {
    'productName': widget.product.productName,
    'productImages': widget.product.productImages,
    'price': widget.product.price,
    'quantity': quantity,
    'description': widget.product.description,
  };

  // Encode the new product details to JSON string
  String productJson = jsonEncode(productDetails);
  
  // Add the new product to the cart list
  cartProducts.add(productJson);
  
  // Save the updated cart list back to SharedPreferences
  await prefs.setStringList('cartProducts', cartProducts);

  setState(() {
    isLoading = false;
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Product added to cart successfully!')),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(text: "Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: btngrey
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentImageIndex = index;
                        });
                      },
                    ),
items: widget.product.productImages.map((image) {
  return Container(
    width: 250, 
    height: 250, 
    child: Image.network(
      image,
      fit: BoxFit.cover,
    ),
  );
}).toList(),


                  ),
      
                              SizedBox(height: 10),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.productImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  currentImageIndex = entry.key;
                }),
                child: Container(
                  width: 13.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentImageIndex == entry.key ? Colors.red : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
                ],
              ),
            ),
          ),
      
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.productName,
                          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '4.9',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: decrementQuantity,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.remove, color: Colors.black, size: 18),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '$quantity',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: incrementQuantity,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.add, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                  
                Text(
                  "Description",
                  style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                  
                SizedBox(height: 10),
                Text(
                  widget.product.description ?? 'No description available',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                Divider(),

                          SizedBox(height: 20),
      
                                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
      
                            Text(
                                              "Reviews",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
      
                                            Text(
                                              "140 Reviews",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                              ),
                                            ),
                          ],
                        ),
      
                         SizedBox(height: 10),
      
                          Divider(),
      
                           SizedBox(height: 40),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total price',
                    style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                  Text(
                    '\$${widget.product.price * quantity}',
                    style: GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
      
              GestureDetector(
                onTap: isLoading ? null : addToCart,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 55),
                  decoration: BoxDecoration(
                    color: isLoading ? Colors.grey : Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Add to cart',
                            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
              ),
            ],
          ),



              ],
            ),
          ),

        ],
      ),
    );
  }
}