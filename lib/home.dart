import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:klitchy2/Produit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Classe/Category.dart';
import 'package:http/http.dart' as http;

import 'Classe/Food.dart';
import 'dart:io';

// Rest of your imports and code

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedCategoryId; // Add a variable to store the selected category
  List<Food> foods = []; // Declare the list here

  List<Category> parseCategories(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }
  Future<List<Category>> fetchDataFromBackend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? restoId = prefs.getString("restaurantId");

    final String baseUrl = "http://192.168.1.18:3000/api/categories/$restoId";

    try {
      final response = await http.get(Uri.parse(baseUrl));
      final dynamic responseData = jsonDecode(response.body);

      if (responseData is List) {
        // Handle JSON array
        List<Category> categories = responseData.map((item) => Category.fromJson(item)).toList();
        return categories;
      } else if (responseData is Map<String, dynamic>) {
        // Handle JSON object
        Category category = Category.fromJson(responseData);
        return [category]; // Return a list containing the single category object
      } else {
        // Handle other cases or report an error
        print('Unexpected response data type');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }

  }

//   Future<void> fetchDataFromServer(int id) async {
//     final url = 'http://192.168.1.18:3000/api/foods/resto/$id';
// print("idcat$id");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setInt("categoryId", id);
//
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         print(response.body);
//         final List<Food> fetchedFoods = data.map((item) => Food.fromJson(item)).toList();
//         setState(() {
//           foods = fetchedFoods;
//         });
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

  Future<void> fetchDataFromServer(int id) async {
    final url = 'http://192.168.1.18:3000/api/foods/resto/$id';
    print("idcat$id");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("categoryId", id);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(response.body);

        // Check if the response data contains at least one item
        if (data.isNotEmpty) {
          // Assuming the first item in the response has the 'id' field
          final int foodId = data[0]['id'];

          // Store the 'id' in SharedPreferences
          prefs.setInt("foodId", foodId);

          setState(() {
            // Process the fetched data as needed
            final List<Food> fetchedFoods = data.map((item) => Food.fromJson(item)).toList();
            foods = fetchedFoods;
          });
        } else {
          print('Response data is empty');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView( // Wrap with a ListView
        children: [

          Container(
            height: 30,
            padding: EdgeInsets.only(left: 28),
            alignment: Alignment.centerLeft,
            child: Text(
              'Hi Omar',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'What do you\nwant to eat today?',
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Color(0xFF006C81),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140, // Adjust this width or use padding to make it fit
                ),
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
              ],
            ),
          )
,
          Container(


           width: 350,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.1), // Set the background color with opacity
              ),
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
 const SizedBox(height: 40,),
          Container(
            height: 150,
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 384,
              child: FutureBuilder(
                future: fetchDataFromBackend(), // Replace with your actual API call function
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final categories = snapshot.data;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        final category = categories?[index];
                        if (category == null) {
                          return Container();
                        }
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (category != null && category.id != null) {
                                  int id = category.id;
                                  fetchDataFromServer(id);
                                }
                              },
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.only(right: 16.0),
                                color: Color(0xFF4D9EAE),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'http://192.168.1.18:3000' + category.imgurl,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 3,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '${category.name ?? "Unknown"}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 990, // Adjust the top position as needed
            left: 0,
            child: Container(
              width: 800,
              height: 300,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 13, 0, 3),
                      child: Row( // Use a Row to align multiple texts horizontally
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recommended for you',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 99), // Add some spacing between the texts
                          GestureDetector(
                            onTap: () {
                              // Add your navigation code here
                              // For example, you can use Navigator to navigate to another screen.
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Produit()), // Replace YourNextScreen() with the destination screen
                              );
                            },
                            child: Text(
                              'More',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4D9EAE),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          final food = foods[index];
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 12.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Produit(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 202,
                                      height: 208,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(17.0),
                                              topRight: Radius.circular(17.0),
                                            ),
                                            child: FractionallySizedBox(
                                              heightFactor: 0.8,
                                              child: Image.network(
                                                'http://192.168.1.18:3000' + food.imgUrl,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 202,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      food.name,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Text(
                                                      '${food.price}dt',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Color(0xFF4D9EAE),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
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
