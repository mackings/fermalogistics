import 'package:fama/Views/Stock/Model/allproducts.dart';
import 'package:fama/Views/Stock/Model/category.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {

  Future<loc.LocationData?> getCurrentLocation() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<String?> retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token']; // Return token for further use
    }

    return null;
  }

  Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return "${place.locality}, ${place.country}";
    }
    return null;
  }


  Future<List<Category>> fetchCategories() async {

  const url = 'https://fama-logistics.onrender.com/api/v1/cart/viewAllCategories';

  final token = await retrieveUserData();

  if (token == null) {
    throw Exception('Authorization token not found');
  }

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List categoriesData = data['categories'];
    return categoriesData.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}


Future<List<Product>> fetchProducts() async {
  const url = 'https://fama-logistics.onrender.com/api/v1/cart/viewAllProducts';
  final token = await retrieveUserData();
  if (token == null) {
    throw Exception('Authorization token not found');
  }

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List productsData = data['products'];
    return productsData.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}



Future<List<Product>> fetchProductsByCategory(String categoryName) async {
  
    final url = 'https://fama-logistics.onrender.com/api/v1/cart/searchProductOrCategoryByName/$categoryName';
    final token = await retrieveUserData();

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsData = data['products'];
      return productsData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products for category $categoryName');
    }
  }



   Future<List<Product>> fetchProductByName(String productName) async {
    final url = 'https://fama-logistics.onrender.com/api/v1/cart/searchProductByName/$productName';
    final token = await retrieveUserData();

    if (token == null) {
      throw Exception('Authorization token not found');
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsData = data['products'];
      return productsData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products for name $productName');
    }
  }


}
