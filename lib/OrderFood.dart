import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchy2/Produit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'Classe/CountController.dart';
import 'Classe/Food.dart';
import 'Orders.dart';

class OrderFood extends StatefulWidget {



  @override
  _DetailsFoodState createState() => _DetailsFoodState();
}

class _DetailsFoodState extends State<OrderFood> {
  Map<String, dynamic> productData = {}; // Variable to hold fetched data
  CountController countController = CountController(0);
  List<Food> foods = []; // Declare the list here
late int idtable ;
  List<Food> selectedFoods = [];
  double total = 0.0; // Initialize total as a state variable

  void handleItemSelection(Food food) {
    // Check if the food is already in the selectedFoods list
    bool foodExists = selectedFoods.contains(food);

    if (foodExists) {
      // If the food exists, remove it
      selectedFoods.remove(food);
    } else {
      // If the food doesn't exist, add it
      selectedFoods.add(food);
    }

    // Update the UI as needed
    // You can use selectedFoods to keep track of selected items
    // You can also use it to calculate the total price
  }



  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
    fetchDataTableRestou();
  }
  Future<dynamic> fetchDataTableRestou() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idtable=  prefs.getInt('idtableResto' )!;
    print("idtable$idtable");
    final response = await http.get(Uri.parse('http://192.168.1.18:3000/api/tableRestos/$idtable'));

    if (response.statusCode == 200) {


      return response.body; // You can return the response body as a string, or you can parse it as JSON, depending on your API response.
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> fetchDataFromServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? categoryIdcategoryId=  prefs.getInt("categoryId");

    final url = 'http://192.168.1.18:3000/api/foods/resto/$categoryIdcategoryId';

    // final url = 'http://10.0.2.2:3000/api/foods/resto/$id';

    print("idcat$categoryIdcategoryId");


    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt("categoryId", id);
    // int id=24
    // print("idcatddd$id");
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
    // final Map<String, dynamic> productData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Map<String, dynamic> productData =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
          //
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(

    image: NetworkImage('http://192.168.1.18:3000' + productData['imgurl']),

    // image: NetworkImage('http://10.0.2.2:3000' + productData['imgurl']),
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
            top: 140,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Place Order ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    SizedBox(height: 9),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 16,  // Set the font size to 16
                            fontWeight: FontWeight.bold,  // Set the font weight to bold
                            color: Colors.black,  // Set the text color to black
                            // Add more style properties as needed
                          ),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: countController,
                          builder: (context, count, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 170.0,
                                  height: 58.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF006C81),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => countController.decrement(),
                                          child: Text('-'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF006C81), // Set the background color to fully transparent
                                          ),
                                        ),


                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              '$count',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () => countController.increment(),
                                          child:  Text('+'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF006C81), // Set the background color to fully transparent
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    FutureBuilder(
                      future: fetchDataTableRestou(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Parse the data as needed
                          final tableData = jsonDecode(snapshot.data); // Assuming your data is in JSON format
                          final tableName = tableData['name']; // Replace 'tableName' with the actual field name from your API response

                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.event_note_sharp,
                                      color: Color(0xFF006C81),
                                      size: 40,
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Table'),
                                        Text(tableName ?? 'Table Name Not Available'), // Display the table name or a default message if it's null
                                      ],
                                    ),
                                    SizedBox(width: 100),
                                    TextButton(
                                      onPressed: () {
                                        // Handle the button click here
                                      },
                                      child: Text(
                                        'View Table',
                                        style: TextStyle(color: Color(0xFF006C81)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    const Text(
                      "Another Toppings",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,

                      ),
                    ),
                    Positioned(
                      top: 900,
                      left: 0,
                      child: Container(
                        width: 600,
                        height: 200,
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [

                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: foods.length,
                                  itemBuilder: (context, index) {
                                    final food = foods[index];
                                    return Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Card(
                                        elevation: 12.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
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
                                                width: 200,
                                                height: 170,
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10.0),
                                                        topRight: Radius.circular(10.0),
                                                      ),
                                                      child: FractionallySizedBox(
                                                        heightFactor: 0.8,
                                                        child: Image.network(
                                                          // 'http://10.0.2.2:3000' + food.imgUrl,

                                                          'http://192.168.1.18:3000' + food.imgUrl,
                                                          fit: BoxFit.cover,
                                                          height: 150,
                                                          width: 260,
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
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(10.0),
                                                                  child: Text(
                                                                    '${food.price}dt',
                                                                    style: const TextStyle(
                                                                      fontSize: 16.0,
                                                                      color: Color(0xFF4D9EAE),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 50,),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    countController.increment();
                                                                    handleItemSelection(food); // Execute your custom function
                                                                  },
                                                                  child: Text('+'),
                                                                  style: ElevatedButton.styleFrom(
                                                                    primary: Color(0xFF4D9EAE),
                                                                  ),
                                                                ),




                                                              ],
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          ValueListenableBuilder<int>(
                            valueListenable: countController,
                            builder: (context, count, child) {
                              double price = double.tryParse(productData['price'].toString()) ?? 0.0;

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 40,
                                  primary: Color(0xFF006C81),
                                  minimumSize: Size(450, 65),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  // Calculate the total price based on the selected items
                                  double newTotal = count * price;
                                  for (Food food in selectedFoods) {
                                    newTotal += food.price ?? 0.0;
                                  }

                                  setState(() {
                                    // Update the total state variable
                                    total = newTotal;
                                  });

                                  // Handle the order action here
                                  // You can use the 'total' variable for your order logic

                                  // For now, let's print the total to the console
                                  print('Total Price: $total DT');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ORDER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(width: 13),
                                    Text(
                                      '$total DT', // Display the total price here
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
