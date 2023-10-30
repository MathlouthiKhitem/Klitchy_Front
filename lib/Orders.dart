import 'package:flutter/material.dart';
import 'ProductDetails.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF717579),
                    fontWeight: FontWeight.bold,
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
                      SizedBox(height: 20),
                      Container(
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/78166_w1024h768c1cx2592cy1728.webp',
                                  width: 150,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'Spaghetti',
                                          style: TextStyle(
                                            color: Color(0xFF006C81),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Medium Spicy Spaghetti',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              '24 DT',
                                              style: TextStyle(
                                                color: Color(0xFF717579),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Text(
                                              'x2',
                                              style: TextStyle(
                                                color: Color(0xFF717579),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
                      SizedBox(height: 20),
                      Container(
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/78166_w1024h768c1cx2592cy1728.webp',
                                  width: 150,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'Spaghetti',
                                          style: TextStyle(
                                            color: Color(0xFF006C81),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          'Medium Spicy Spaghetti',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              '29 DT',
                                              style: TextStyle(
                                                color: Color(0xFF717579),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Text(
                                              'x1',
                                              style: TextStyle(
                                                color: Color(0xFF717579),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
                      const Divider(
                        color: Color(0xFF006C81),
                        thickness: 2,
                        height: 20,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("#12344124"),
                          SizedBox(
                            width: 150,
                          ),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              color: Color(0xFF006C81),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 170,
                padding: EdgeInsets.fromLTRB(22, 0, 74, 0), // Remove padding bottom
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
                  children: [
                    Expanded(
                      child: Text("In my table", style: TextStyle(fontSize: 14)),
                    ),
                    SizedBox(
                      width: 190, // Adjust the width as needed
                    ),
                    Expanded(
                      child: Text(
                        "Add new",
                        style: TextStyle(
                          color: Color(0xFF006C81),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 20, 103), // Adjust padding bottom
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19.0),
                  ),
                  elevation: 9.0,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0), // Adjust padding as needed
                        child: Image.asset(
                          'assets/images/placeholder (1).png',
                          width: 42,
                          height: 42,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Leila Ali',
                              style: TextStyle(
                                color: Color(0xFF717579),
                              ),
                            ),
                            Text(
                              'Guest',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          )







        ],
      ),
    );
  }
}
