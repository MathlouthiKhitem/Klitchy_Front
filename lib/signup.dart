import 'package:flutter/material.dart';
import 'api/client.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    phoneController.dispose();
    nameController.dispose();
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
            SizedBox(height: 50),
            Image.asset(
              'assets/images/Klitchy.png', // Remplacez 'assets/your_image.png' par le chemin de votre image
              width: 100, // Définissez la largeur souhaitée
              height: 50, // Définissez la hauteur souhaitée
            ),
            SizedBox(height: 10),
            Text(
              'Restaurant App',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 10),
            Column(

              children: <Widget>[
                Container(
                  width: 700, // Set the desired width of the card
                  height: 700, // Set the desired height of the card
                  child: Card(
                    elevation: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0), // Set the border radius
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        const ListTile(
                          title: Text(
                            'Create your account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              // Make the text bold
                            ),
                          ),
                        ),
                        const ListTile(
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
                                  controller: nameController, // Assign the controller to the TextField

                                  decoration: InputDecoration(
                                    hintText: 'Name',
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
                                      Icons.email_outlined, // Use the user icon
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
                        const SizedBox(height: 13.0),
                         ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0), // Add padding to ListTile content
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(

                                  obscureText: true, // Hide the text for password input
                                  controller: passwordController, // Assign the controller to the TextField

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
                        const SizedBox(height: 13.0),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0), // Add padding to ListTile content
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: phoneController, // Assign the controller to the TextField

                                  decoration: InputDecoration(
                                    hintText: 'Phone',
                                    prefixIcon: Icon(
                                      Icons.phone, // Use the lock icon for password input
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
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 40,
                              primary: Color(0xFF006C81),
                              minimumSize: Size(400, 65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () async {
                              String name = nameController.text;
                              String email = emailController.text;
                              String password = passwordController.text;
                              String phone = phoneController.text;

                              final response = await createClient(name, email, password, phone);

                              if (response != null && response.statusCode == 200) {
                                // Show a success SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Color(0xFF006C81), // Set the background color

                                    content: Text('Registration Successful'),
                                  ),
                                );
                                print('Client created successfully');
                              } else {
                                // Failed to create the client. Handle the error here.
                                if (response != null) {
                                  print('Failed to create client. Status code: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                }
                              }
                            },

                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 200),
                                Icon(Icons.login, color: Colors.white, size: 30,),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),


                        SizedBox(

                          child: TextButton(
                            onPressed: () {
                              // Add logic for "Don't have an account?" here
                            },
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Color(0xFF757575), // Set text color to black (000000)
                                fontSize: 16, // Set the font size to 16 pixels
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // Add spacing from the top for the "Create an account" button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFB2DFDB),
                            minimumSize: Size(319, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(68),
                            ),
                          ),
                          onPressed: () async {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()), // Replace Login with your actual sign-in screen class
                            );
                          },
                          child: Text(
                            'Sign in',
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



