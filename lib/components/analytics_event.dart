// analytics
import 'package:firebase_analytics/firebase_analytics.dart';

//dart
import 'dart:async';

// utils
import '../data_models/analytics_event_type.dart';

class Analytics {
  static String _isEventType;
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // logEvent()
  static Future analyticsLogEvent(
      AnalyticsEventType eventType, Map<String, dynamic> parameterMap) async {
    _isEventType = await _enumToString(eventType);
    await analytics.logEvent(
      name: _isEventType,
      parameters: parameterMap,
    );
  }

  // Convert the value defined Enum to String
  static Future _enumToString(eventType) async {
    return eventType.toString().split('.')[1];
  }
}
