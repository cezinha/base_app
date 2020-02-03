import 'package:base_app/screens/components/drawer.dart';
import 'package:base_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:base_app/util/analytics.dart';
import 'package:base_app/screens/components/connection.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  //_HomeScreenState(this.analytics, this.observer);

  //final FirebaseAnalyticsObserver observer;
  //final FirebaseAnalytics analytics;

  @override
  initState() {
    super.initState();
    Analytics.setCurrentScreen("/home", "Home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partyou'),
        backgroundColor: Colors.lightBlue[300],
      ),
      drawer: MainDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.lightBlueAccent,
              Colors.blue[500],
              Colors.blue[700],
              Colors.lightBlue[900],
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            AlertOfflineWidget(),
            Container(
              height: 100.0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Topo',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ConnectionWidget()
                    )
                  ]
                )
              ),
              padding: EdgeInsets.only(bottom: 15.0),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    color: Colors.red[300],
                  ),
                  Expanded(child: Container(
                    color: Colors.green[300],
                    child: Center(
                      child: Text('Esquerda',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black
                        )
                      ),
                    ),
                  )),
                  Container(
                    width: 50.0,
                    color: Colors.red[300],
                  ),
                ]
              )
            )
          ],
        ),
      )
    );
  }
}

class AlertOfflineWidget extends StatefulWidget {
  AlertOfflineWidget({Key key}) : super(key: key);

  @override
  _AlertOfflineWidgetState createState() => _AlertOfflineWidgetState();
}

class _AlertOfflineWidgetState extends State<AlertOfflineWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.isOffline,
      builder: (context, isOffline) {
        if (isOffline) {
          Future.delayed(Duration.zero, () => showAlert(context));
        }
        return Container();
      },
    );
  }
}

void showAlert(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Wifi"),
        content: Text("Wifi not detected. Please activate it."),
      )
  );
}