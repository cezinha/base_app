import 'dart:async';

import 'package:redux/redux.dart';
import 'package:base_app/util/connection.dart';
import 'package:base_app/redux/actions.dart';
import 'package:base_app/model.dart';

List<Middleware<AppState>> createStoreMiddleware() => [
      TypedMiddleware<AppState, InitConnectionAction>(_initConnectionStatus)
    ];

Future _initConnectionStatus(Store<AppState> store, InitConnectionAction action, NextDispatcher next) async {
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.connectionChange.listen((dynamic hasConnection) {
    bool isOffline = !hasConnection;

    if (store.state.isOffline != isOffline) {
      print(store.state);
      store.dispatch(ChangedConnectionAction(isOffline));
    }
  });
  next(action);
}