import 'package:fama/Views/Stock/Api/stockservice.dart';
import 'package:fama/Views/Stock/Views/Cart/Pages/qoute.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/formfields.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';



class CartAddress extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartAddress({Key? key, required this.cartItems}) : super(key: key);

  @override
  ConsumerState<CartAddress> createState() => _CartAddressState();
}

class _CartAddressState extends ConsumerState<CartAddress> {
  final ApiService apiService = ApiService();
  final TextEditingController mylocation = TextEditingController();
  String? currentAddress;
  loc.LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    print(widget.cartItems);
  }

  Future<void> getCurrentLocation() async {
    currentLocation = await apiService.getCurrentLocation();
    if (currentLocation != null) {
      String? fullAddress = await apiService.getAddressFromCoordinates(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      );

      if (fullAddress != null) {
        setState(() {
          currentAddress = fullAddress;
        });
      } else {
        setState(() {
          currentAddress = 'Address not found';
        });
      }
    }
  }

  void _useCurrentLocation() {
    if (currentAddress != null) {
      setState(() {
        mylocation.text = currentAddress!;
      });
    }
  }

  Future<void> _saveAddressToPreferences(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('shipping_address', address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Shipping Address"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                labelText: "Country / Region",
                hintText: "Enter Location",
                controller: mylocation,
                onChanged: (value) {},
              ),
              SizedBox(height: 15),
              if (currentAddress != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Location: $currentAddress',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: _useCurrentLocation,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: btngrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Use Current Location',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 49.h,
              ),


CustomButton(
  text: "Continue",
  onPressed: () async {
    await _saveAddressToPreferences("${currentAddress==null?mylocation.text:currentAddress}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShippingQuote(
          cartItems: widget.cartItems,
          shippingAddress: "${currentAddress==null?mylocation.text:currentAddress}",
        ),
      ),
    );
  },
),

 

            ],
          ),
        ),
      ),
    );
  }
}
