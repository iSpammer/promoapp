import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promoapp/pages/Main/HomePage.dart';
import 'package:promoapp/styles/const.dart';
import 'package:promoapp/utils/modal_progress_hud.dart';
import 'package:promoapp/widgets/button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'regiser';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showSpinner = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
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
                  _email = value;
                  //Do something with the user input.
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
                  tag: "register",
                  child: new Button(
                    text: "Regiser",
                    color: Colors.blue,
                    fn: () async {
                      setState(() {
                        _showSpinner = true;
                      });
                      try {
                        print("hii $_email");
//                        final newUser = await ;
                        //TODO registration setup
                        var newUser;
                        if (newUser != null) {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (
                                BuildContext context,
                              ) =>
                                  HomePage(),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          _showSpinner = false;
                        });
                      }
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
