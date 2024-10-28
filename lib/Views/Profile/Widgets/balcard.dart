import 'package:flutter/material.dart';



class BalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback onTopUp;

  const BalanceCard({
    Key? key,
    required this.balance,
    required this.onTopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 343,
            height: 97,
            child: Column(
              
              children: [
                Container(
                  width: 343,
                  height: 97,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 33,
                        top: 25,
                        child: Opacity(
                          opacity: 0.30,
                          child: Container(
                            width: 277,
                            height: 72,
                            decoration: ShapeDecoration(
                              color: Color(0xFFEA2A3A), // Red color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.39),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 17,
                        top: 13,
                        child: Opacity(
                          opacity: 0.60,
                          child: Container(
                            width: 309,
                            height: 80,
                            decoration: ShapeDecoration(
                              color: Color(0xFFEA2A3A), // Red color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 343,
                          height: 88,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEA2A3A), // Red color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 17,
                        top: 22,
                        child: Container(
                          width: 309,
                          height: 45,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0.20,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    '\N${balance.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0.08,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Top Up',
                                      style: TextStyle(
                                        color: Color(0xFFEA2A3A),
                                        fontSize: 11,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.20,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 26,
                                      height: 26,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Icon(Icons.add), // Replace with your icon
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

