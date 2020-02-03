import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:base_app/util/analytics.dart';
import 'package:base_app/screens/home.dart';
import 'package:global_configuration/global_configuration.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _SplashPageState();
  @override
  Widget build(BuildContext context) {
    if (GlobalConfiguration().getBool("force_update") == true) {
      String title = GlobalConfiguration().getString("force_update_title");
      String message = GlobalConfiguration().getString("force_update_message");
      return BlockPage(title: title, message: message);
    }
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

class BlockPage extends StatefulWidget {
  final String title;
  final String message;
  BlockPage({ Key key, this.title, this.message }) : super(key: key);

  @override
  _BlockPageState createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  _BlockPageState();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue
              ]
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.fitWidth
              ),
            ),
            margin: EdgeInsets.all(140.0),
          )
        ),
        Center(
          child: Card(
            elevation: 10,
            margin: EdgeInsets.all(80.0),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                color: Colors.white
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Theme.of(context).textTheme.subhead.fontSize
                        ),
                      ),
                    ),
                    Text(
                      widget.message,
                      style: TextStyle(color: Colors.grey, fontSize: Theme.of(context).textTheme.body1.fontSize),
                    )
                  ]
                )
              )
            )
          )
        )
      ]
    );
  }

  @override
  initState() {
    super.initState();
    Analytics.setCurrentScreen("/splash", "splash screen");
  }
}