import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'EmailVerification.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController emailController = TextEditingController();
  String confirmationMessage = ""; // Store confirmation message here
  late String? responseBody;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendForgotPasswordRequest() async {
    final apiUrl = 'http://10.0.2.2:3000/api/clients/forget'; // Replace with your API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': emailController.text}),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userEmailPassword",emailController.text );
      print( "prefs.getString("")");
      print( prefs.getString("userEmailPassword"));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body.toString()); // Decode the response

        setState(() {
          confirmationMessage = "Code sent to your email. Expires in 5 minutes.";
        });


        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeVerfication(responseBody: jsonResponse['value']), // Pass the 'value' from the decoded response
          ),
        );
        print(jsonResponse);

      }
      else if (response.statusCode == 500) {
        // Handle the case where no account with the email was found
        setState(() {
          confirmationMessage = "No account with this email to restore";
        });
      } else {
        // Handle other error cases
        setState(() {
          confirmationMessage = "An error occurred";
        });
      }
    } catch (e) {
      // Handle network or other errors here
      print('Error: $e');
      setState(() {
        confirmationMessage = "An error occurred";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Code to handle navigation when the back icon is clicked
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Color(0xFF717579),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF717579),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Column(
              children: <Widget>[
                Container(
                  width: 700,
                  height: 600,
                  child: Card(
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        ListTile(
                          title: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ListTile(
                          title: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Enter the email address to get a link \n",
                                ),
                                TextSpan(
                                  text: "to reset your password",
                                  style: TextStyle(
                                    color: Color(0xFF006C81),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFF006C81),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF006C81)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 27.0),
                        Text(confirmationMessage), // Display confirmation message
                        SizedBox(height: 27),
                        SizedBox(height: 40.0),
                        Text("Code was sent to your email"),
                        SizedBox(height: 40.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 40,
                              primary: Color(0xFF006C81),
                              minimumSize: Size(450, 65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: sendForgotPasswordRequest, // Call the function
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Confirm Email ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
          ],
        ),
      ),
    );
  }
}
