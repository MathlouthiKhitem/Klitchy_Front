import 'package:flutter/material.dart';
import '../ListOrders.dart';
import '../Produit.dart';
import '../Profilesettings.dart'; // Make sure this import is correct.
import '../home.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("G-Store ESPRIT"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Store",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "Bibliothèque",
                icon: Icon(Icons.list_alt_outlined),
              ),
              Tab(
                text: "Panier",
                icon: Icon(Icons.shopping_basket),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            Produit(),
            ListOrders(), // Make sure this is the correct widget name.
          ],
        ),
      ),
    );
  }
}
