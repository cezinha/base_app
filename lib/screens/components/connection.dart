import 'package:base_app/model.dart';
import 'package:base_app/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ConnectionWidget extends StatefulWidget {
  ConnectionWidget({Key key}) : super(key: key);

  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.isOffline,
      onInit: (store) => store.dispatch(InitConnectionAction()),
      builder: (context, isOffline) {
        return (isOffline)?
          new Icon(
            Icons.signal_wifi_off,
            color: Colors.white,
            size: 30.0,
          ) :
          new Icon(
            Icons.signal_wifi_4_bar,
            color: Colors.white,
            size: 30.0,
          );
      }
    );
  }
}