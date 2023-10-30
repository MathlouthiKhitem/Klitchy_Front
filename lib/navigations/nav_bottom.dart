import 'package:flutter/material.dart';
import '../ListOrders.dart';
import '../Produit.dart';
import '../Profilesettings.dart'; // Make sure this import is correct.
import '../home.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _currentIndex = 0;
  final List<Widget> _interfaces = [
    HomeScreen(),
    Produit(),
    ListOrders(), // Make sure this is the correct widget name.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _interfaces[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: "order",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.propane_tank_rounded),
            label: "Promo",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        selectedItemColor: Color(0xFF006C81), // Set the selected item color
      ),
    );
  }
}
