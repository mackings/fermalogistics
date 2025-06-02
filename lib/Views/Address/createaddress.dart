import 'package:getnamibia/Views/Address/success.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:getnamibia/Views/widgets/countrycode.dart';
import 'package:getnamibia/Views/widgets/formfields.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Createaddress extends ConsumerStatefulWidget {
  const Createaddress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateaddressState();
}

class _CreateaddressState extends ConsumerState<Createaddress> {
  TextEditingController firstname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pickupaddress = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: btngrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'Add New Address',
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 20),
          child: Column(
            children: [
              CustomTextFormField(
                  labelText: "Full Name *",
                  hintText: 'Mac Kingsley',
                  controller: firstname,
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              CountryCodeTextFormField(
                labelText: 'Phone Number*',
                hintText: "8137159066",
                controller: phone,
                onChanged: (value) {},
                countryCodes: ['+234', '+91', '+44'],
                selectedCountryCode: '+234',
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  labelText: "Pickup Address *",
                  hintText: 'Sparklight estate Lagos Nigeria',
                  controller: firstname,
                  suffix: Image.asset('assets/location.png'),
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  labelText: "State *",
                  hintText: 'Lagos',
                  controller: state,
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              CustomTextFormField(
                  labelText: "City *",
                  hintText: 'Ikotun',
                  controller: city,
                  onChanged: (value) {}),
              SizedBox(
                height: 2.h,
              ),
              TextSwitchRow(
                  label: 'Set as Default Address',
                  initialSwitchValue: true,
                  onSwitchChanged: (value) {}),
              SizedBox(
                height: 3.h,
              ),
              CustomButton(
                  text: 'Save & Continue',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressSuccess()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class TextSwitchRow extends StatefulWidget {
  final String label;
  final bool initialSwitchValue;
  final ValueChanged<bool> onSwitchChanged;

  TextSwitchRow({
    required this.label,
    required this.initialSwitchValue,
    required this.onSwitchChanged,
  });

  @override
  _TextSwitchRowState createState() => _TextSwitchRowState();
}

class _TextSwitchRowState extends State<TextSwitchRow> {
  late bool _isSwitchOn;

  @override
  void initState() {
    super.initState();
    _isSwitchOn = widget.initialSwitchValue;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitchOn = value;
    });
    widget.onSwitchChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: '${widget.label}',
          fontWeight: FontWeight.w400,
          color: Colors.grey
        ),
        Switch(
          value: _isSwitchOn,
          onChanged: _toggleSwitch,
          focusColor: btncolor,
          activeTrackColor: btncolor,
        ),
      ],
    );
  }
}
