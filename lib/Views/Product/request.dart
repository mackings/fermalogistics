import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Requestproduct extends ConsumerStatefulWidget {
  const Requestproduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestproductState();
}

class _RequestproductState extends ConsumerState<Requestproduct> with SingleTickerProviderStateMixin {
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
        appBar: AppBar(
          title: CustomText(text: 'Request Product'),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: Container(
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
                        title: 'Tab 1',
                        isActive: _activeIndex == 0,
                      ),
                      CustomTab(
                        title: 'Tab 2',
                        isActive: _activeIndex == 1,
                      ),
                      CustomTab(
                        title: 'Tab 3',
                        isActive: _activeIndex == 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: _tabController != null // Ensure the TabController is initialized
            ? TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    color: Colors.white,
                    child: Center(child: CustomText(text: 'Content for Tab 1')),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(child: CustomText(text: 'Content for Tab 2')),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(child: CustomText(text: 'Content for Tab 3')),
                  ),
                ],
              )
            : Container(), // Show an empty container while the TabController is initializing
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
        color: isActive ? Colors.white : Colors.grey.shade200, // Adjust the background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: title,
        color: isActive ? Colors.black : Colors.black,
      ),
    );
  }
}