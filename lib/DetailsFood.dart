import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchy2/Produit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'OrderFood.dart';
import 'Orders.dart';

class DetailsFood extends StatefulWidget {
  // final int productId;
  //
  // DetailsFood({required this.productId});

  @override
  _DetailsFoodState createState() => _DetailsFoodState();
}

class _DetailsFoodState extends State<DetailsFood> {
  Map<String, dynamic> productData = {}; // Variable to hold fetched data
  late int productId; // Déclarez productId comme un entier

  @override
  void initState() {
    super.initState();
    fetchData();
  }



  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int? productId = prefs.getInt("foodId");

    // final url = Uri.parse('http://10.0.2.2:3000/api/foods/$productId'); // Replace with your API endpoint

    final url = Uri.parse('http://192.168.1.18:3000/api/foods/$productId'); // Replace with your API endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        productData = jsonData; // Update the state with the fetched data
      });
    } else {
      // Handle the error when the API request fails
      print('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments is int) {
      productId = arguments; // Convertissez en tant qu'entier
    } else {

    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(1, 40, 10, 30), // Adjust margins as needed
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.pink,
                size: 30, // Icon size
              ),
              onPressed: () {
                Navigator.pop(context); // This will return to the previous screen
              },
            ),
          ),

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(

    // image: NetworkImage('http://10.0.2.2:3000' + productData['imgurl']),

    image: NetworkImage('http://192.168.1.18:3000' + productData['imgurl']),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.6), // Adjust the opacity as needed
          ),
          // Product Details Card
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Name ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          ' ${productData['name']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          ' ${productData['price']}DT',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xFF006C81),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' ${productData['description']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    // Circular Image in Review
                    Positioned(
                      top: 700,
                      left: 28,
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/placeholder (1).png'), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Leila Ali",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Lorem ipsum dolor sit amet,"
                                ,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 39,
                    ),
                    //ken kif scene code order
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 24.0), // Add padding to the button content
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       elevation: 40,
                    //       primary: Color(0xFF006C81), // Set the button background color
                    //       minimumSize: Size(450, 65), // Set the button size (width, height)
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(16), // Set the border radius
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       // Navigate to the sign-up screen
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(builder: (context) => Orders()), // Replace SignUpScreen with your actual sign-up screen class
                    //       );
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           'ORDER',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20, // Set the font size to 20 pixels
                    //           ),
                    //         ),
                    //         SizedBox(width: 16), // Add spacing between icon and text
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0), // Add padding to the button content
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 40,
                          primary: Color(0xFF006C81), // Set the button background color
                          minimumSize: Size(450, 65), // Set the button size (width, height)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // Set the border radius
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderFood(),
                              settings: RouteSettings(
                                arguments: productData, // Transmettez les données du produit ici
                              ),
                            ),
                          );


                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ORDER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20, // Set the font size to 20 pixels
                              ),
                            ),
                            SizedBox(width: 16), // Add spacing between icon and text

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
