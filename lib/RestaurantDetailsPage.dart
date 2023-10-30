import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:klitchy2/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigations/nav_bottom.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final String restaurantId;

  RestaurantDetailsPage(this.restaurantId, {super.key});

  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  Map<String, dynamic> restaurantData = {};

  @override
  void initState() {
    super.initState();
    fetchRestaurantData();
  }

  Future<void> fetchRestaurantData() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.18:3000/api/restos/${widget.restaurantId}'));
    // final response = await http.get(
    //     Uri.parse('http://10.0.2.2:3000/api/restos/${widget.restaurantId}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)["resto"];
      setState(() {
        restaurantData = data;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("restaurantId", widget.restaurantId);

    } else {
      throw Exception('Failed to load restaurant data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with gray effect
          if (restaurantData["imgurl"] != null)
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white12, // Adjust the color for the desired gray effect
                BlendMode.saturation, // Blend mode for gray effect
              ),
              child: Image.network(
                restaurantData["imgurl"],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          // Content overlay
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 75),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Expanded(
                       // Adjust this height as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Container with an image
                              Container(
                                width: 100.0,
                                height: 90.0,
                                child: Container(
                                  width: 100.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: NetworkImage(restaurantData["imgurl"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 10),

                              // Column with text
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${restaurantData["name"]}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '${restaurantData["address"]}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Add more fields as needed
                                ],
                              ),
                            ],
                          )
                          ,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NavigationBottom()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                // Color when the button is pressed
                                return Color(0xFF006C81); // Change to your desired color
                              }
                              // Default color
                              return Color(0xFF006C81); // Change to your default color
                            },
                          ),
                          // Set the desired width and height
                          minimumSize: MaterialStateProperty.all<Size>(Size(350, 62)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
                            ),
                          ),
                        ),
                        child: Text(
                          'View menu',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                      )



                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
