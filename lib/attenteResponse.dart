import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class AttenteResponse extends StatefulWidget {
  @override
  _AttenteResponseState createState() => _AttenteResponseState();
}

class _AttenteResponseState extends State<AttenteResponse> {
  late IO.Socket socket;

  void initSocket() {
    socket = IO.io(
        // 'http://10.0.2.2:3030',
        'http://192.168.1.52:3030',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
  }
  void sendMessageToServer(String message) {
    socket.emit("send_message", message);
  }

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          Image.asset(
            'assets/images/Klitchy.png', // Replace with your image path
            width: 100, // Set your desired width
            height: 50, // Set your desired height
          ),
          SizedBox(height: 140,),
          Text(
            'En attente de confirmation',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20), // Add spacing between text elements
          Text(
            'Veuillez saisir votre nom complet, afin que nous puissions nous souvenir de vous et vous envoyer des informations sur nos promotions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 80,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 20,
              primary: Color(0xFF006C81),
              minimumSize: Size(200, 65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              sendMessageToServer("alo"); // Call the function here if needed
            },
            child: Text(
              'Request ', // Updated text here
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
