import 'package:flutter/material.dart';
import 'package:klitchy2/signup.dart';
import 'package:klitchy2/splashscreen.dart';

import 'CreatNewPassword.dart';
import 'Forgot Password.dart';
import 'ListOrders.dart';
import 'OrderFood.dart';
import 'ProductDetails.dart';
import 'Produit.dart';
import 'Profilesettings.dart';
import 'QRCodeScreen.dart';
import 'RestaurantDetailsPage.dart';
import 'attenteResponse.dart';
import 'home.dart';
import 'listrestaurant.dart';
import 'login.dart';
import 'navigations/nav_bottom.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    // // home: OrderFood(),
    //   //home: Password(),
    //  //home: RestaurantDetailsPage("1"),
    //  //home: ListResturant(),
    //    //home: ListOrders(),
    // //    home: Signup(),
    // //   home:   Splashscreen(),
    // //   home: ProfileSetting(),
    // //   home: Produit(),
    // //   home: ProductDetails(),
    // //   home: HomeScreen(),
    //   //home:NavigationBottom(),
    //  // home: CreateNewPassword(),
    //  // home: ScanScreen(),
    // );
    return MaterialApp(
      title: "Klitchy",
      routes: {
        // "/": (context) {
        //   return SplashScreen();
        // },
        "/": (context) {
          return Login();
        },
        "/signup": (context) {
          return Signup();
        },
        "/CreateNewPassword": (context) {
          return CreateNewPassword();
        },

        "/resetPwd": (context) {
          return Password();
        },
        "/home": (context) {
          return HomeScreen();
        },
        "/home/update": (context) {
          return ProfileSetting();
        },
        "/homeBottom": (context) {
          return NavigationBottom();
        },


      },
    );
  }
}


