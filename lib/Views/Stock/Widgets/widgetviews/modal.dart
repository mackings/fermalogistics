import 'package:getnamibia/Views/Stock/Views/Cart/Pages/qoute.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class ShippingQuoteModal extends StatefulWidget {
  final ShippingOption initialSelection;
  final double shippingCost;
  final List<Map<String, dynamic>> cartItems;
  final String shippingAddress;
  final ValueChanged<ShippingOption> onSelectionChanged;

  const ShippingQuoteModal({
    Key? key,
    required this.initialSelection,
    required this.shippingCost,
    required this.cartItems,
    required this.shippingAddress,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ShippingQuoteModal> createState() => _ShippingQuoteModalState();
}

class _ShippingQuoteModalState extends State<ShippingQuoteModal> {
  ShippingOption? selectedShipping;
  double currentShippingCost = 0.0;

  @override
  void initState() {
    super.initState();
    selectedShipping = widget.initialSelection;
    currentShippingCost = widget.shippingCost;
  }

  void _updateShippingOption(ShippingOption? option) {
    if (option != null) {
      setState(() {
        selectedShipping = option;
        currentShippingCost = option == ShippingOption.cargo ? 30.0 : 400.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Shipping Method",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          // Cargo Shipping Option
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFEFF0),
              child: SvgPicture.asset('assets/ship.svg'),
            ),
            title: CustomText(text: 'Cargo'),
            subtitle: CustomText(text: '3-5 days', color: Colors.grey),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(text: "\$30", fontWeight: FontWeight.w600),
                Radio<ShippingOption>(
                  value: ShippingOption.cargo,
                  groupValue: selectedShipping,
                  onChanged: _updateShippingOption,
                ),
              ],
            ),
          ),

          // Express Shipping Option
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFEFF0),
              child: SvgPicture.asset('assets/plane.svg'),
            ),
            title: CustomText(text: 'Express'),
            subtitle: CustomText(text: '1-2 days', color: Colors.grey),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(text: "\$400", fontWeight: FontWeight.w600),
                Radio<ShippingOption>(
                  value: ShippingOption.express,
                  groupValue: selectedShipping,
                  onChanged: _updateShippingOption,
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Divider(),

          // Display Shipping Address
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.red),
            title: CustomText(
              text: widget.shippingAddress.isNotEmpty
                  ? widget.shippingAddress
                  : "No address selected",
            ),
          ),

          SizedBox(height: 20),

          // Confirm Button
          CustomButton(
            text: "Change Type",
            onPressed: () {
              if (selectedShipping != null) {
                widget.onSelectionChanged(selectedShipping!);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}


