import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:promoapp/pages/AddData.dart';
import 'package:promoapp/pages/Detail.dart';
import 'package:promoapp/pages/Main/HomePage.dart';
import 'package:promoapp/pages/WelcomeScreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:promoapp/styles/theme.dart';
import 'package:promoapp/widgets/CollapsingNavigationDrawer.dart';

void main() {
  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent));
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Promo App",
      home: HomePage(
        username: "osos",
      ),
    );
  }
}
