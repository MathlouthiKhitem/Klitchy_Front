import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klitchy2/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Classe/Category.dart';
import 'Classe/Food.dart';
import 'DetailsFood.dart';
import 'ProductDetails.dart';
import 'package:http/http.dart' as http;
class Produit extends StatefulWidget {
  @override
  _ProduitState createState() => _ProduitState();
}

class _ProduitState extends State<Produit> {
  List<Food> products = []; // List to store fetched products
  final String _baseUrl = "10.0.2.2:9090";


  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData when the widget is initialized
  }
  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? categoryId = prefs.getInt("categoryId");

    if (categoryId == null) {
      return;
    }
    // final uri = Uri.parse('http://10.0.2.2:3000/api/foods/resto/$categoryId');

    final uri = Uri.parse('http://192.168.1.18:3000/api/foods/resto/$categoryId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("jsonData$jsonData");
      setState(() {
        products = List<Food>.from(jsonData.map((data) => Food.fromJson(data)));
      });
    } else {
      print('Failed to load data from the API');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // Handle back button tap
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez Home() par votre page d'accueil
                          (route) => false, // Supprime toutes les routes précédentes
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFF717579),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 30,
                ),
                const Text(
                  'Menus',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF717579),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: 800,
                padding: EdgeInsets.all(1.0),
                child: Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      // Display the products fetched from the API
                      for (var product in products)
                        GestureDetector(
                          onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsFood(),
                                  settings: RouteSettings(
                                    arguments: product.id,
                                  ),
                                ),
                              );

                              // Handle product tap
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailsFood(productId: product.id), // Utilisez l'opérateur ! pour indiquer que product.id n'est pas nul
                              //   ),
                              // );

                          },

                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19.0),
                            ),
                            elevation: 9.0,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    if (product.imgUrl != null)
                                    Image.network(
                                        // 'http://10.0.2.2:3000' + product.imgUrl,

                                        'http://192.168.1.18:3000' + product.imgUrl,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover
                                    ),

                                    Expanded(
                                      child: Column(
                                        children: [
                                          if (product.name != null)
                                          ListTile(
                                            title: Text(
                                              product.name, // Use product data
                                              style: TextStyle(
                                                color: Color(0xFF006C81),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 1.0),
                                          if (product.description != null)// Add spacing between ListTile widgets
                                          ListTile(

                                            title: Text(
                                              product.description, // Use product data
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 1.0), // Add spacing between ListTile widgets
                                          ListTile(
                                            title: Text(
                                              '${product.price}dt',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color(0xFF4D9EAE),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 20,),
                      // Add more cards or content here
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         SizedBox(height: 30),
  //         Container(
  //           child: Row(
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                 },
  //                 child: const Padding(
  //                   padding: EdgeInsets.all(20.0),
  //                   child: Icon(
  //                     Icons.arrow_back_ios_rounded,
  //                     color: Color(0xFF717579),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 30,
  //               ),
  //               const Text(
  //                 'Menus',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   color: Color(0xFF717579),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: SingleChildScrollView(
  //             child: Container(
  //               width: 800,
  //               padding: EdgeInsets.all(1.0),
  //               child: Card(
  //                 elevation: 4.0,
  //                 margin: EdgeInsets.all(16.0),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(24.0),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: 20,),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) => ProductDetails()),
  //                         );
  //                       },
  //                       child: Card(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(19.0),
  //                         ),
  //                         elevation: 9.0,
  //                         child: Stack(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Image.asset(
  //                                   'assets/images/Klitchy.png',
  //                                   width: 150,
  //                                   height: 50,
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                                 Expanded(
  //                                   child: Column(
  //                                     children: [
  //                                       ListTile(
  //                                         title: Text(
  //                                           'Spaghetti',
  //                                           style: TextStyle(
  //                                             color: Color(0xFF006C81),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       ListTile(
  //                                         title: Text(
  //                                           'Medium Spicy Spaghetti',
  //                                           style: TextStyle(
  //                                             color: Colors.black,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       ListTile(
  //                                         title: Text(
  //                                           '24 DT',
  //                                           style: TextStyle(
  //                                             color: Color(0xFF717579),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Positioned(
  //                               top: 0,
  //                               left: 0,
  //                               child: Container(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 color: Colors.white,
  //                                 child: Icon(
  //                                   Icons.favorite,
  //                                   color: Colors.red,
  //                                   size: 24.0,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) => ProductDetails()),
  //                         );
  //                       },
  //                       child: Card(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(19.0),
  //                         ),
  //                         elevation: 9.0,
  //                         child: Stack(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Image.asset(
  //                                   'assets/images/Klitchy.png',
  //                                   width: 150,
  //                                   height: 50,
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                                 Expanded(
  //                                   child: Column(
  //                                     children: [
  //                                       ListTile(
  //                                         title: Text(
  //                                           'Spaghetti',
  //                                           style: TextStyle(
  //                                             color: Color(0xFF006C81),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       ListTile(
  //                                         title: Text(
  //                                           'Medium Spicy Spaghetti',
  //                                           style: TextStyle(
  //                                             color: Colors.black,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       ListTile(
  //                                         title: Text(
  //                                           '24 DT',
  //                                           style: TextStyle(
  //                                             color: Color(0xFF717579),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Positioned(
  //                               top: 0,
  //                               left: 0,
  //                               child: Container(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 color: Colors.white,
  //                                 child: Icon(
  //                                   Icons.favorite,
  //                                   color: Colors.red,
  //                                   size: 24.0,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) => ProductDetails()),
  //                         );
  //                       },
  //                       child: Card(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(19.0),
  //                         ),
  //                         elevation: 9.0,
  //                         child: Stack(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Image.asset(
  //                                   'assets/images/Klitchy.png',
  //                                   width: 150,
  //                                   height: 50,
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                                 Expanded(
  //                                   child: Column(
  //                                     children: [
  //                                       ListTile(
  //                                         title: Text(
  //                                           'Spaghetti',
  //                                           style: TextStyle(
  //                                             color: Color(0xFF006C81),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       ListTile(
  //                                         title: Text(
  //                                           'Medium Spicy Spaghetti',
  //                                           style: TextStyle(
  //                                             color: Colors.black,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       ListTile(
  //                                         title: Text(
  //                                           '24 DT',
  //                                           style: TextStyle(
  //                                             color: Color(0xFF717579),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Positioned(
  //                               top: 0,
  //                               left: 0,
  //                               child: Container(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 color: Colors.white,
  //                                 child: Icon(
  //                                   Icons.favorite,
  //                                   color: Colors.red,
  //                                   size: 24.0,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20,),
  //                     // Add more cards or content here
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
