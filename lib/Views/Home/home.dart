import 'package:getnamibia/Views/Home/dashboard.dart';
import 'package:getnamibia/Views/Profile/Views/Profilehome.dart';
import 'package:getnamibia/Views/Send%20Product/send.dart';
import 'package:getnamibia/Views/Shipments/Views/shipmentHome.dart';
import 'package:getnamibia/Views/Stock/Views/Stockhome.dart';
import 'package:getnamibia/Views/Tracking/home.dart';
import 'package:getnamibia/Views/Tracking/live.dart';
import 'package:getnamibia/Views/widgets/colors.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _initializePages();
 
  }


  void _initializePages() {
    
    _pages = [
      
      Dashboard(),
      ShipmentsHome(),
      StockHome(),
      SearchHome(),
      ProfileHome()

    ];
    
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: _pages[_selectedIndex],
  bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.delivery_dining_sharp),
        label: 'Shipping',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.inventory),
        label: 'Stock',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code),
        label: 'Tracking',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Account',
      ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: btncolor, // Color for the selected label and icon
    unselectedItemColor: Colors.black54, // Change this color for better visibility
    onTap: _onItemTapped,
    elevation: 0,
  ),
);


  }
}