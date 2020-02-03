import 'dart:async';
import 'package:base_app/model.dart';
import 'package:base_app/redux/middleware.dart';
import 'package:base_app/redux/reducers.dart';
import 'package:base_app/util/connection.dart';
import 'package:base_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';
import 'generated/l10n.dart';

Store<AppState> createStore = Store<AppState>(
  appReducer,
  initialState: new AppState(),
  middleware: createStoreMiddleware()
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GlobalConfiguration().loadFromAsset("settings");
  // Create your store as a final variable in the main function or inside a
  // State object. This works better with Hot Reload than creating it directly
  // in the `build` function.
  final store = createStore;

  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  runApp(BaseApp(store: store));
}

class BaseApp extends StatelessWidget {
  final Store<AppState> store;

  BaseApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The StoreProvider should wrap your MaterialApp or WidgetsApp. This will
    // ensure all routes have access to the store.
    return StoreProvider<AppState>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
      store: store,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData.dark(),
        title: 'Base App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Base App'),
          ),
          body: Center(
            child: Container(
              child: SplashPage(),
            )
          ),
        ),
      ),
    );
  }
}
