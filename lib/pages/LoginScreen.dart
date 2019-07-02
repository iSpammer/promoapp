import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promoapp/pages/Main/HomePage.dart';
import 'package:promoapp/styles/const.dart';
import 'package:promoapp/utils/modal_progress_hud.dart';
import 'package:promoapp/widgets/button.dart';
import 'package:http/http.dart' as HTTP;

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;
  bool _showSpinner = false;

  Future<List> _login() async {
    setState(() {
      _showSpinner = true;
    });
    final response = await HTTP.post(
      "http://10.0.2.2/SQL_TEST/login.php",
      body: {
        "username": _username,
        "password": _password,
      },
    );
    var user = json.decode(response.body);
    if (user.length == 0) {}
    try {
      if (user != null) {
        var name = user[0]['usermame'];
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (
              BuildContext context,
            ) =>
                HomePage(username: this._username),
          ),
        );
      } else {
        //TODO failed login
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _showSpinner = false;
      });
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Flexible(
                child: Hero(
                  tag: "login",
                  child: new Button(
                    text: "Login",
                    color: Colors.lightBlue,
                    fn: () {
                      _login();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
