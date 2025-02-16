
import 'package:fama/Views/Drivers/Chats/Views/chathome.dart';
import 'package:fama/Views/Drivers/Deliveries/Views/Deliveries.dart';
import 'package:fama/Views/Drivers/Pickups/Views/pickuphome.dart';
import 'package:fama/Views/Home/dashboard.dart';
import 'package:fama/Views/Profile/Views/Profilehome.dart';
import 'package:fama/Views/Stock/Views/Stockhome.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:flutter/material.dart';


class DriverHomePage extends StatefulWidget {

  const DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _selectedIndex = 0;


  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _initializePages();
 
  }


  void _initializePages() {
    
    _pages = [
      
      PickupHome(),
      Deliveries(),
      ChatsPage(),
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
        label: 'Delivery',
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.message_outlined),
        label: 'Messages',
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
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