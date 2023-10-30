import 'package:flutter/material.dart';

import 'Orders.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/78166_w1024h768c1cx2592cy1728.webp',
                ), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.4), // Adjust the opacity as needed
          ),
          // Product Details Card
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
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
                    Text(
                      'Chicken Fillet',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Main dish',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF006C81),
                      ),
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
                        Text(
                          '24DT',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xFF006C81),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore , sed do eiusmod tempor incididunt ut labore consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore  sed do eiusmod",
                      style: TextStyle(fontSize: 14),
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
