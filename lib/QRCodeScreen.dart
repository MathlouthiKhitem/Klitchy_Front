import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RestaurantDetailsPage.dart';
import 'api/client.dart';
import 'attenteResponse.dart';
import 'login.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qrstr = "let's Scan it";
  var height, width;

  @override
  void initState() {
    super.initState();

    // Initiate the scanning process when the screen is opened
    startScanning();

  }

  Future<void> startScanning() async {
    // Request camera permission
    var status = await Permission.camera.request();
    if (status.isGranted) {
      try {
        FlutterBarcodeScanner.scanBarcode(
          '#2A99CF',
          'cancel',
          true,
          ScanMode.QR,
        ).then((value) async {
          setState(() {
            qrstr = value;

          });

          if (value != null) {
            // Send the QR code to the server to fetch the table data
            final tableData = await fetchTableByQrCode(qrstr);
            if (tableData.statusCode == 200) {
              final Map<String, dynamic> responseData = json.decode(tableData.body);
              final Map<String, dynamic> tableResto = responseData['tableResto'];
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? idClient = prefs.getString('idClient');
              print("idClient$idClient");
              print("tableResto$tableResto");
              if (tableResto != null) {
                final int? id = tableResto['id'];
                final String name = tableResto['name'];
                final String? owner = tableResto['owner'];
                final int? restoId = tableResto['restoId'];
                print("int$restoId");

                if (id != null && idClient != null) {
                  if (owner == null) {
                    // Owner is not null, perform the update and navigate to the restaurant details
                    final updateResult = await updateTableOwner(id, idClient);
             print("owner$owner");
                    print("restoId: $restoId");
                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    prefs.setInt('idtableResto',id );
                    print("restoId before push: $restoId");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsPage(restoId?.toString() ?? ""),
                      ),
                    );

                    ;

                  }
                  else if (owner != null) {
                    // Handle the case where the update fails
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttenteResponse(), // Navigate to login
                      ),
                    );
                  }
                }

              }
            }
          }
        });
      } catch (e) {
        setState(() {
          qrstr = 'unable to read this';
        });
      }
    }
  }

  Future<http.Response> updateTableOwner(int? tableId, String? newOwnerId) async {
    // final Uri apiUrl = Uri.parse("http://10.0.2.2:3000/api/tableRestos/setOwner");

    final Uri apiUrl = Uri.parse("http://192.168.1.18:3000/api/tableRestos/setOwner");


    final Map<String, dynamic> requestBody = {
      'tableId': tableId,
      'newOwnerId': newOwnerId,
    };
    final http.Response response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print(qrstr);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning QR code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              qrstr,
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
            SizedBox(height: width),
          ],
        ),
      ),
    );
  }
}


