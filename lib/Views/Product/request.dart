import 'package:fama/Views/Product/cardrequestwidget.dart';
import 'package:fama/Views/Product/newrequest.dart';
import 'package:fama/Views/Product/reqstatus.dart';
import 'package:fama/Views/Product/widgets.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Requestproduct extends ConsumerStatefulWidget {
  const Requestproduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestproductState();
}

class _RequestproductState extends ConsumerState<Requestproduct>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Request Product'),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = constraints.maxWidth > 600
                    ? constraints.maxWidth * 0.8
                    : constraints.maxWidth -
                        32; // Adjust width based on screen width

                return Center(
                  child: Container(
                    width: containerWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          CustomTab(
                            title: 'Ongoing',
                            isActive: _activeIndex == 0,
                          ),
                          CustomTab(
                            title: 'Cancelled',
                            isActive: _activeIndex == 1,
                          ),
                          CustomTab(
                            title: 'Completed',
                            isActive: _activeIndex == 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: _tabController != null // Ensure the TabController is initialized
            ? TabBarView(
                controller: _tabController,
                children: [
                  Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          ImageWithText(
                            title: "No Request Yet",
                            bodyText1:
                                "You haven't placed any request yet,requests",
                            bodyText2: "will be displayed here",
                            svgPath: '',
                          ),
                        ],
                      )),

                  //TAB2

                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => requeststatus()));
                        },
                        child: RequestCard(
                            title: "Scanner",
                            subtitle: '100 pcs',
                            leadingIcon: Icons.scanner,
                            trailingIcon: 'Pending',
                            text1: 'Time Placed',
                            text2: "Placed at"),
                      ),
                    ],
                  ),

                  //TAB3

                  Container(
                    color: Colors.white,
                    child: Center(child: CustomText(text: 'Content for Tab 3')),
                  ),
                ],
              )
            : Container(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: btncolor,
            shape: CircleBorder(),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Newrequest()));
            }),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isActive;

  CustomTab({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CustomText(
          text: title,
          fontSize: 10.sp,
          color: isActive ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}
