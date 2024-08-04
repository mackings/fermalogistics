import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineData {
  final Color indicatorColor;
  final Color beforeLineColor;
  final Color afterLineColor;

  TimelineData({
    required this.indicatorColor,
    required this.beforeLineColor,
    required this.afterLineColor,
  });
}

class Timelines extends StatelessWidget {
  final TimelineData firstTile;
  final TimelineData middleTile1;
  final TimelineData middleTile2;
  final TimelineData lastTile;

  const Timelines({
    Key? key,
    required this.firstTile,
    required this.middleTile1,
    required this.middleTile2,
    required this.lastTile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double timelineWidth = constraints.maxWidth;
        return SizedBox(
          width: timelineWidth,
          child: Container(
            height: 5.h,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    isFirst: true,
                    indicatorStyle: IndicatorStyle(
                      color: firstTile.indicatorColor,
                    ),
                    afterLineStyle: LineStyle(
                      color: firstTile.afterLineColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    isFirst: false,
                    indicatorStyle: IndicatorStyle(
                      color: middleTile1.indicatorColor,
                    ),
                    beforeLineStyle: LineStyle(
                      color: middleTile1.beforeLineColor,
                    ),
                    afterLineStyle: LineStyle(
                      color: middleTile1.afterLineColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    isFirst: false,
                    indicatorStyle: IndicatorStyle(
                      color: middleTile2.indicatorColor,
                    ),
                    beforeLineStyle: LineStyle(
                      color: middleTile2.beforeLineColor,
                    ),
                    afterLineStyle: LineStyle(
                      color: middleTile2.afterLineColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    isLast: true,
                    indicatorStyle: IndicatorStyle(
                      color: lastTile.indicatorColor,
                    ),
                    beforeLineStyle: LineStyle(
                      color: lastTile.beforeLineColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
