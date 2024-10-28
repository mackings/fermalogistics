
import 'package:fama/Views/Stock/Api/stockservice.dart';
import 'package:fama/Views/Stock/Model/allproducts.dart';
import 'package:fama/Views/Stock/Model/category.dart';
import 'package:fama/Views/Stock/Widgets/location.dart';
import 'package:fama/Views/Stock/Widgets/productcard.dart';
import 'package:fama/Views/Stock/Widgets/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;


class StockHome extends StatefulWidget {
  const StockHome({super.key});

  @override
  State<StockHome> createState() => _StockHomeState();
}

class _StockHomeState extends State<StockHome> {
  final ApiService apiService = ApiService();

  dynamic userToken;
  dynamic userImage;
  String? currentAddress;
  loc.LocationData? currentLocation;

  List<Category> categories = [];
  List<Product> products = [];
  String selectedCategory = 'All';

  TextEditingController search = TextEditingController();

  Future<void> _retrieveUserData() async {
    userToken = await apiService.retrieveUserData();
    if (userToken != null) {
      setState(() {
        print(userToken);
      });
    }
  }

  Future<void> getCurrentLocation() async {
    currentLocation = await apiService.getCurrentLocation();
    if (currentLocation != null) {
      String? address = await apiService.getAddressFromCoordinates(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      );

      if (address != null) {
        List<String> addressParts = address.split(', ');
        String city = addressParts[0];
        String country = addressParts.length > 1 ? addressParts[1] : '';

        String shortCountry = country.isNotEmpty ? country : 'Unknown';

        setState(() {
          currentAddress = '$city, $shortCountry';
        });
      } else {
        setState(() {
          currentAddress = 'Address not found';
        });
      }
    }
  }

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await apiService.fetchCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (error) {
      print('Failed to load categories: $error');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final fetchedProducts = await apiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (error) {
      print('Failed to load products: $error');
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    try {
      if (category == 'All') {
        await fetchProducts();
      } else {
        final fetchedProducts = await apiService.fetchProductsByCategory(category);
        setState(() {
          products = fetchedProducts;
        });
      }
    } catch (error) {
      print('Failed to load products for category $category: $error');
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    _retrieveUserData();
    fetchCategories();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            children: [
              LocationDisplay(
                currentAddress: currentAddress,
                onRefresh: () {},
                onSettings: () {},
              ),
              const SizedBox(height: 20),
              SearchTextField(
                controller: search,
                hintText: "Search Anything",
              ),
              SizedBox(height: 13),
              Image.asset("assets/girlpng.png"),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: Text(
                        'All',
                        style: GoogleFonts.montserrat(
                          color: selectedCategory == 'All' ? Colors.white : Colors.black,
                        ),
                      ),
                      selected: selectedCategory == 'All',
                      onSelected: (isSelected) {
                        setState(() {
                          selectedCategory = 'All';
                        });
                        fetchProductsByCategory('All');
                      },
                      selectedColor: Colors.red,
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      checkmarkColor: Colors.white,
                    ),
                    SizedBox(width: 8),
                    
                    ...categories.map((category) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            checkmarkColor: Colors.white,
                            label: Text(
                              category.category,
                              style: GoogleFonts.montserrat(
                                color: selectedCategory == category.category
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            selected: selectedCategory == category.category,
                            onSelected: (isSelected) {
                              setState(() {
                                selectedCategory = category.category;
                              });
                              fetchProductsByCategory(category.category);
                            },
                            selectedColor: Colors.red,
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Wrap(
                spacing: 25,
                runSpacing: 15,
                children: products.map((product) {
                  return ProductCard(
                    productName: product.productName,
                    price: 'N${product.price}',
                    rating: 4.5,
                    imageUrl: product.productImages.isNotEmpty
                        ? product.productImages[0]
                        : 'https://via.placeholder.com/150',
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

