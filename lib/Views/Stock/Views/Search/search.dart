import 'package:getnamibia/Views/Stock/Model/allproducts.dart';
import 'package:getnamibia/Views/Stock/Views/Search/widgets/socksearchfield.dart';
import 'package:getnamibia/Views/Stock/Widgets/Product%20Details/productdetails.dart';
import 'package:getnamibia/Views/Stock/Widgets/productcard.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/stockservice.dart';



class SearchStock extends StatefulWidget {
  const SearchStock({super.key});

  @override
  State<SearchStock> createState() => _SearchStockState();
}

class _SearchStockState extends State<SearchStock> {
  TextEditingController searchController = TextEditingController();
  List<Product> searchResults = [];
  bool isLoading = false;
  List<String> recentSearches = [];
    final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
     _retrieveUserCurrency();
    _loadRecentSearches();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (searchController.text.isNotEmpty) {
      _fetchSearchResults(searchController.text);
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList('recentProductSearches') ?? [];
    setState(() {});
  }

  Future<void> _saveToRecent(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!recentSearches.contains(query)) {
      recentSearches.add(query);
      await prefs.setStringList('recentProductSearches', recentSearches);
      setState(() {});
    }
  }

  Future<void> _clearAllRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recentProductSearches');
    setState(() {
      recentSearches.clear();
    });
  }

  Future<void> _removeFromRecent(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.remove(query);
    await prefs.setStringList('recentProductSearches', recentSearches);
    setState(() {});
  }

  Future<void> _fetchSearchResults(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Product> products = await ApiService().fetchProductByName(query);
      setState(() {
        searchResults = products;
      });
      if (!recentSearches.contains(query)) {
        _saveToRecent(query);
      }
    } catch (e) {
      print('Error fetching search results: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  dynamic userCurrency;
    Future<void> _retrieveUserCurrency() async {
    userCurrency = await apiService.retrieveUserCurrency();
    if (userCurrency != null) {
      setState(() {
        print(userCurrency);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Search Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StockSearchTextField(
              controller: searchController,
              hintText: "Search Product",
            ),
            const SizedBox(height: 10),
            if (isLoading) CircularProgressIndicator(color: Colors.transparent,),
            if (!isLoading && searchResults.isEmpty && recentSearches.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Recent Searches",
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: _clearAllRecentSearches,
                    child: CustomText(
                      text: "Clear All",
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                children: recentSearches.map((query) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        searchController.text = query;
                        _fetchSearchResults(query);
                      },
                      child: Text(query),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => _removeFromRecent(query),
                    ),
                  );
                }).toList(),
              ),
            ],

            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                            currency: userCurrency,
                            ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        ProductCard(
                          productName: product.productName,
                          price: 'N${product.price}',
                          rating: 4.5, 
                          imageUrl: product.productImages.isNotEmpty
                              ? product.productImages[0]
                              : 'https://via.placeholder.com/150',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            
          ],
        ),
      ),
    );
  }
}
