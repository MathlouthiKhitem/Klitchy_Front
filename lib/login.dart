

import 'package:flutter/material.dart';
import 'package:klitchy2/Forgot%20Password.dart';
import 'package:klitchy2/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Produit.dart';
import 'api/client.dart';
import 'listrestaurant.dart';
import 'navigations/nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Image.asset(
              'assets/images/Klitchy.png', // Remplacez 'assets/your_image.png' par le chemin de votre image
              width: 100, // Définissez la largeur souhaitée
              height: 50, // Définissez la hauteur souhaitée
            ),

            SizedBox(height: 10),
            Text(
              'Restaurant App',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 30),
            Column(
              children: <Widget>[
                Container(
                  width: 700, // Set the desired width of the card
                  height: 600, // Set the desired height of the card
                  child: Card(
                    elevation: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0), // Set the border radius
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListTile(
                          title: Text(
                            'Welcome back',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // Make the text bold
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                            style: TextStyle(
                              fontSize: 12.0, // Set the font size to 12 pixels
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0), // Add padding to ListTile content
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: emailController, // Assign the controller to the TextField

                                  decoration: InputDecoration(
                                    hintText: 'Email',

                                    prefixIcon: Icon(
                                      Icons.person_2_outlined, // Use the user icon
                                      color: Color(0xFF006C81),
                                      // Set the icon color to #006C81
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF006C81)), // Change the border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 13.0),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0), // Add padding to ListTile content
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: passwordController, // Assign the controller to the TextField

                                  obscureText: true, // Hide the text for password input
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline, // Use the lock icon for password input
                                      color: Color(0xFF006C81), // Set the icon color to #006C81
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF006C81)), // Change the border color when focused
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 27),
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

                            onPressed: () async {

                              String email = emailController.text;
                              String password = passwordController.text;
                               print(password);
                              final response = await loginClient( email, password);

                              if (response != null && response.statusCode == 200) {
                                print("response");
                                print(response);
                                print("responselogin: ${response.body}"); // Print the response body
                                String responseBody = response.body;


                                Map<String, dynamic> decodedResponse = json.decode(responseBody);


                                String idClient = decodedResponse['id'].toString(); // Convert integer to string
                                String name = decodedResponse['name'];
                                String phone = decodedResponse['phone'];
                                String email = decodedResponse['email'];
                                String password = decodedResponse['password'];
                                String createdAt = decodedResponse['createdAt'];
                                String updatedAt = decodedResponse['updatedAt'];

                                SharedPreferences prefs = await SharedPreferences.getInstance();

                                prefs.setString('idClient',idClient );
                                print("----------");
                                print(prefs.getString("idClient"));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ListResturant()), // Replace SignUpScreen with your actual sign-up screen class
                                  );
                                print('Client created successfully');
                              } else {

                                if (response != null) {
                                  print('Failed to create client. Status code: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  Icons.login,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            )

                          ),
                        ),
                        SizedBox(height: 19),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/resetPwd");

                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Color(0xFF006C81), // Set text color
                              decoration: TextDecoration.underline,
                              fontSize: 20, // Set the font size to 16 pixels
                            ),
                          ),
                        ),

                        SizedBox(

                          child: TextButton(
                            onPressed: () {
                              // Add logic for "Don't have an account?" here
                            },
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Color(0xFF757575), // Set text color to black (000000)
                                fontSize: 16, // Set the font size to 16 pixels
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12), // Add spacing from the top for the "Create an account" button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFB2DFDB),
                            minimumSize: Size(319, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(68),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/signup");

                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(
                              color: Color(0xFF006C81),
                              fontSize: 16,
                            ),
                          ),
                        )


                      ],
                    ),
                  ),
                ),
                // You can add more widgets below the card if needed
              ],
            ),
          ],

        ),
      ),
    );
  }
}



