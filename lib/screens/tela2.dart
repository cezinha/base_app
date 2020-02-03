import 'package:base_app/screens/components/drawer.dart';
import 'package:flutter/material.dart';

import 'package:base_app/util/analytics.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';

class Tela2Screen extends StatefulWidget {
  @override
  _Tela2ScreenState createState() => _Tela2ScreenState();

}

class _Tela2ScreenState extends State<Tela2Screen> {
  //_HomeScreenState(this.analytics, this.observer);

  //final FirebaseAnalyticsObserver observer;
  //final FirebaseAnalytics analytics;

  @override
  initState() {
    super.initState();
    Analytics.setCurrentScreen("/tela2", "Tela2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela 2'),
        backgroundColor: Colors.lightBlue[300],
      ),
      drawer: MainDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        height: 100.0,
        child: Center(
          child: Text('Tela 2',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black
            )
          ),
        ),
      )
    );
  }
}