import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:gangaji_pul/service/analytics_service.dart';

class AnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics _firebaseAnalytics;

  AnalyticsServiceImpl(this._firebaseAnalytics);

  @override
  Future<void> logApiCall(String name, {Map<String, Object>? parameters}) {
    return _firebaseAnalytics.logEvent(name: "api_call_$name", parameters: parameters);
  }
}
