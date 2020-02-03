import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'dart:async';

class Analytics {
  static final FirebaseAnalytics analytics = FirebaseAnalytics();
  static final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // logEvent()
  static Future<void> logEvent(String eventType, Map<String, dynamic> parameterMap) async {
    await analytics.logEvent(
      name: eventType,
      parameters: parameterMap,
    );
  }

  static Future<void> setCurrentScreen(String name, String nameOverride) async {
    await analytics.setCurrentScreen(
      screenName: name,
      screenClassOverride: nameOverride,
    );
  }
}