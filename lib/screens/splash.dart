import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:base_app/util/analytics.dart';
import 'package:base_app/screens/home.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _SplashPageState();
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }

  @override
  initState() {
    super.initState();
    Analytics.setCurrentScreen("/splash", "splash screen");
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blueAccent,
            Colors.lightBlue
          ]
        ),
        navigateAfterSeconds: HomeScreen(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
            fit: BoxFit.fitWidth
          ),
        ),
        margin: EdgeInsets.all(140.0),
      )
    ]
  );
}
