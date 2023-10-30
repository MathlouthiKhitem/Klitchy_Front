import 'package:flutter/material.dart';

class ListOrders extends StatefulWidget {
  @override
  _ListOrdersState createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  List<bool> isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 150,
            child: Text(
              'Orders',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 28,
            child: Container(
              width: 350,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Row(
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
          ),
          Positioned(
            top: 220,
            left: 90,
            width: 400,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.0), // Set the border radius for the entire ToggleButtons
              child: ToggleButtons(
                fillColor: Color(0xFF006C81),
                borderColor: Color(0xFF006C81),
                selectedBorderColor: Color(0xFF006C81),
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = !isSelected[buttonIndex];
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                    child: Text(
                      "All",
                      style: TextStyle(
                        color: isSelected[0] ? Colors.black : Colors.black, // Change the text color
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                    child: Text(
                      "On Delivery",
                      style: TextStyle(
                        color: isSelected[1] ? Colors.black : Colors.black, // Change the text color
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: isSelected[2] ? Colors.black : Colors.black, // Change the text color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 280, // Adjust the top position
            left: 28, // Adjust the left position
            child: Container(
              width: 350, // Set the desired width
              height: 200, // Set the desired height
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Set the border-radius
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0), // Adjust padding as needed
                        child: Image.asset(
                          'assets/images/placeholder (1).png',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Desserts',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006C81),
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Blueberry Pancake',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                        Row(
                          children: [
                            Text(
                              '24DT',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Text(
                              'x2',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                            const Divider(
                              color: Color(0xFF006C81), // Couleur de la ligne de séparation
                              thickness: 3, // Épaisseur de la ligne de séparation (2 pixels)
                              height: 30, // Hauteur de la ligne de séparation (20 pixels)
                              indent: 0, // Marge à gauche de la ligne de séparation (10 pixels)
                              endIndent: 0, // Marge à droite de la ligne de séparation (10 pixels)
                            ),
                            Row(
                              children: [
                                Text(
                                  '#12344124',
                                  style: TextStyle(
                                    fontSize: 16.0,

                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'On Delivery',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                   color: Color(0xFFFF7F23)
                                  ),
                                ),
                              ],
                            ),
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 500, // Adjust the top position
            left: 28, // Adjust the left position
            child: Container(
              width: 350, // Set the desired width
              height: 300, // Set the desired height
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Set the border-radius
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 0, 30, 150), // Adjust padding as needed
                        child: Image.asset(
                          'assets/images/placeholder (1).png',
                          width: 76,
                          height: 76,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Spagethi',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006C81),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Medium Spicy Spagethi ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '24DT',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'x2',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Medium Spicy Spagethi ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],

                            ),
                            const Divider(
                              color: Color(0xFF006C81), // Couleur de la ligne de séparation
                              thickness: 3, // Épaisseur de la ligne de séparation (2 pixels)
                              height: 30, // Hauteur de la ligne de séparation (20 pixels)
                              indent: 0, // Marge à gauche de la ligne de séparation (10 pixels)
                              endIndent: 0, // Marge à droite de la ligne de séparation (10 pixels)
                            ),
                          ],

                        ),
                      ),

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
}
