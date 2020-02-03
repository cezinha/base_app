import 'dart:async';
import 'dart:convert';
import 'package:base_app/model.dart';
import 'package:base_app/redux/middleware.dart';
import 'package:base_app/redux/reducers.dart';
import 'package:base_app/util/connection.dart';
import 'package:base_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:redux/redux.dart';
import 'generated/l10n.dart';

Store<AppState> createStore = Store<AppState>(
  appReducer,
  initialState: new AppState(),
  middleware: createStoreMiddleware()
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await initializeConfig();
  // Create your store as a final variable in the main function or inside a
  // State object. This works better with Hot Reload than creating it directly
  // in the `build` function.
  final store = createStore;

  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  runZoned(() {
    runApp(BaseApp(store: store));
  }, onError: Crashlytics.instance.recordError);
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

Future<void> initializeConfig() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if(prefs.getKeys().isNotEmpty) {
    String savedConfig = await prefs.getString('config');
    if (savedConfig.isNotEmpty) {
      Map config = jsonDecode(savedConfig);
      GlobalConfiguration().loadFromMap(config);
    }
  } else {
    await GlobalConfiguration().loadFromAsset("settings");
  }

  final String version = GlobalConfiguration().getString("version");
  String remoteConfig = GlobalConfiguration().getString("remote_config");
  remoteConfig = remoteConfig.replaceAll('\$version', version);
  try{
    await GlobalConfiguration().loadFromUrl(remoteConfig);
  }catch(e){
    print('Error GlobalConfiguration: $e');
  }
  await prefs.setString('config', jsonEncode(GlobalConfiguration().appConfig));
}