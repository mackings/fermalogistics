import 'package:fama/Views/Home/dashboard.dart';
import 'package:fama/Views/Send%20Product/send.dart';
import 'package:fama/Views/Shipments/Views/shipmentHome.dart';
import 'package:fama/Views/Stock/Views/Stockhome.dart';
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
      SendProduct(),
      SendProduct()

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
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: ROrange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        elevation: 0,
      ),
    );
  }
}