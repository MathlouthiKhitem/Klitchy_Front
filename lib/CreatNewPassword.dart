import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klitchy2/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewPassword extends StatefulWidget {
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
late String EmailPassowrd ;
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }




  void changePassword() async {
    String newPassword = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EmailPassowrd= prefs.getString("userEmailPassword")!;
    print(EmailPassowrd);
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      // Handle empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please enter both password and confirm password."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: Text("OK"),

              ),
            ],
          );
        },
      );
    } else if (newPassword != confirmPassword) {
      // Handle password mismatch
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Passwords do not match."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Passwords match, you can proceed with changing the password

      // Send a POST request to your server to change the password
      var url = Uri.parse('http://10.0.2.2:3000/api/clients/restorPassword');
      var body = {
        'email': EmailPassowrd, // Replace with the user's login value
        'password': newPassword, // Use the new password
      };

      var response = await http.put(url, body: body);

      if (response.statusCode == 200) {
        // Password changed successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Password has been changed successfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Handle server error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to change password. Please try again."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Image.asset(
              'assets/images/Klitchy.png',
              width: 100,
              height: 50,
            ),
            SizedBox(height: 10),
            Text(
              'Restaurant App',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 500,
                  height: 500,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        ListTile(
                          title: Text(
                            'New Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Please write your new password",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF006C81),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF006C81),
                                      ),
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
                            horizontal: 24.0,
                          ),
                          title: Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Color(0xFF006C81),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF006C81),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              primary: Color(0xFF006C81),
                              minimumSize: Size(300, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: changePassword,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Confirm Password',
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
