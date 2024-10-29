import 'package:fama/Views/Stock/Views/Cart/Pages/qoute.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class ShippingQuoteModal extends StatefulWidget {
  final ShippingOption initialSelection;
  final ValueChanged<ShippingOption> onSelectionChanged;

  const ShippingQuoteModal({
    Key? key,
    required this.initialSelection,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ShippingQuoteModal> createState() => _ShippingQuoteModalState();
}

class _ShippingQuoteModalState extends State<ShippingQuoteModal> {
  ShippingOption? selectedShipping;

  @override
  void initState() {
    super.initState();
    selectedShipping = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFEFF0),
              child: SvgPicture.asset('assets/ship.svg'),
            ),
            title: CustomText(
              text: 'Cargo',
            ),
            subtitle: CustomText(
              text: '3-5 days',
              color: Colors.grey,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "\$30",
                  fontWeight: FontWeight.w600,
                ),
                Radio<ShippingOption>(
                  value: ShippingOption.cargo,
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
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFFFEFF0),
              child: SvgPicture.asset('assets/plane.svg'),
            ),
            title: CustomText(
              text: 'Express',
            ),
            subtitle: CustomText(
              text: '1-2 days',
              color: Colors.grey,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "\$400",
                  fontWeight: FontWeight.w600,
                ),
                Radio<ShippingOption>(
                  value: ShippingOption.express,
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
          SizedBox(height: 20),
          
          CustomButton(text: "Change Type", onPressed: (){
                          if (selectedShipping != null) {
                widget.onSelectionChanged(selectedShipping!);
              }
          })
        ],
      ),
    );
  }
}
