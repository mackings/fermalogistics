import 'package:flutter/material.dart';

class TrackingDotsWidget extends StatelessWidget {
  final int currentStage;

  TrackingDotsWidget({
    required this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309,
      height: 14,
      child: Stack(
        children: [
          // Line
          Positioned(
            left: 0,
            top: 7,
            child: Container(
              width: 309,
              height: 2,
              child: Stack(
                children: [
                  Positioned(
                    left: 3,
                    top: 0,
                    child: Container(
                      width: 303,
                      height: 2,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),
                  if (currentStage > 0)
                    Positioned(
                      left: 3,
                      top: 0,
                      child: Container(
                        width: 103,
                        height: 2,
                        decoration: BoxDecoration(color: Color(0xFFEA2A3A)),
                      ),
                    ),
                  if (currentStage > 1)
                    Positioned(
                      left: 87,
                      top: 0,
                      child: Container(
                        width: 103,
                        height: 2,
                        decoration: BoxDecoration(color: Color(0xFFEA2A3A)),
                      ),
                    ),
                  if (currentStage > 2)
                    Positioned(
                      left: 171,
                      top: 0,
                      child: Container(
                        width: 103,
                        height: 2,
                        decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Dots
          Positioned(
            left: 0,
            top: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Column(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: ShapeDecoration(
                          color: i < currentStage
                              ? Color(0xFFEA2A3A)
                              : Color(0xFFD9D9D9),
                          shape: CircleBorder(),
                        ),
                      ),
                      if (i < 3 - 1)
                        SizedBox(
                          width: 84,
                          height: 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: i < currentStage - 1
                                  ? Color(0xFFEA2A3A)
                                  : Colors.white,
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
