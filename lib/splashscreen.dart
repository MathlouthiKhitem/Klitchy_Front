import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23), // Border radius
              ),
              child: Container(
                width: 500, // Set the desired width of the card
                height: 500, // Set the desired height of the card
                color: Colors.black, // Set the background color of the card to black
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5, // Set the desired aspect ratio (width/height)
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/placeholder.png', // Replace with your image path
                          fit: BoxFit.cover, // Adjust the image fit as needed
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1, // Make the remaining space below the image
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0), // Add padding around the text
                            child: Text(
                              'Text Above Image 1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0), // Add padding around the text
                            child: Text(
                              'Great taste, great sensation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0), // Add padding around the text
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.6, // Set the button width to half of the card's width
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
                  // Add login logic here
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Set the font size to 20 pixels
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
