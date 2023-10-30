import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
Future<http.Response> createClient(String name, String email, String password, String phone) async {
  final String baseUrls = "http://10.0.2.2:3000/api/clients/";

  try {
    final response = await http.post(
      Uri.parse(baseUrls),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );

    return response; // Return the response object
  } catch (e) {
    // Handle network or other errors here.
    print('Error creating client: $e');
    return http.Response('Error', 500); // Return an error response with a status code
  }
}
Future<http.Response> loginClient( String email, String password) async {
  // final String baseUrls = "http://10.0.2.2:3000/api/clients/login";
 final String baseUrls ='http://192.168.1.18:3000/api/clients/login'; // Corrected the URL


  try {
    final response = await http.post(
      Uri.parse(baseUrls),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'email': email,
        'password': password,

      }),

    );
    print("response: ${response.body}"); // Print the response body
    return response; // Return the response object
  } catch (e) {
    // Handle network or other errors here.
    print('Error creating client: $e');
    return http.Response('Error', 500); // Return an error response with a status code
  }
}
Future<http.Response> fetchTableByQrCode(String qrCode) async {
  final String apiUrl = "http://192.168.1.18:3000/api/tableRestos/getTable";
  // final String apiUrl = "http://10.0.2.2:3000/api/tableRestos/getTable";

  print(apiUrl);
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'qrcode': qrCode}),
    );
    return response; // Return the response object
  } catch (e) {
    // Handle network or other errors here.
    print('Error creating client: $e');
    return http.Response(
        'Error', 500); // Return an error response with a status code
  }
}
Future<void> sendForgotPasswordRequest(String email) async {
  final apiUrl = 'http://10.0.2.2:3000/api/clients/forget'; // Replace with your API URL

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

    } else if (response.statusCode == 500) {
      // Handle the case where no account with the email was found

    } else {
      // Handle other error cases

    }
  } catch (e) {
    // Handle network or other errors here
    print('Error: $e');

  }
}
