import 'package:fama/Views/Address/createaddress.dart';
import 'package:fama/Views/widgets/button.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Addaddress extends ConsumerStatefulWidget {
  const Addaddress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddaddressState();
}

class _AddaddressState extends ConsumerState<Addaddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Add new address"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Setup Address',
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                    color: Color(0xFFFFF5F6),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: CustomText(
                    text: "Home",
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: CustomText(
                    text: 'Setup address for home',
                    color: Colors.grey,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home,
                      color: btncolor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                    color: Color(0xFFFFF5F6),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: CustomText(
                    text: 'Add more address',
                    color: Colors.grey,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: btncolor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 35.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFF5F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: ListTile(
                                        title: CustomText(
                                          text: "Use current location",
                                          fontWeight: FontWeight.w600,
                                        ),
                                        leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Image.asset(
                                                "assets/location.png")),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Createaddress()));
                                    },
                                    child: Container(
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFF5F6),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: ListTile(
                                          title: CustomText(
                                            text: "Enter Address Manually",
                                            fontWeight: FontWeight.w600,
                                          ),
                                          leading: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Image.asset(
                                                  "assets/hand.png")),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
