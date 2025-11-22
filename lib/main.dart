import 'package:flutter/material.dart';
import 'package:shopkart/routes/home.dart';
import 'package:shopkart/routes/browse.dart';
import 'package:shopkart/routes/wishlist.dart';
import 'package:shopkart/routes/bag.dart';
import 'package:shopkart/routes/account.dart';
import 'package:shopkart/routes/login.dart';
import 'package:shopkart/routes/signup.dart';
import 'package:shopkart/routes/dashboard.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      //'/': (context) => (),
      '/home': (context) => Home(),
      '/browse' : (context) => Browse(),
      '/wishlist' : (context) => Wishlist(),
      '/bag' : (context) => Bag(),
      '/account' : (context) => Account(),
      '/login' : (context) => Login(),
      '/signup' : (context) => Signup(),
      '/dashboard' : (context) => Dashboard(),
    },
  ));
}
