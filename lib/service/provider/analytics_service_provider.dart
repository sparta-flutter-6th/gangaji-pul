import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gangaji_pul/service/analytics_service.dart';
import 'package:gangaji_pul/service/analytics_service_impl.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final analytics = FirebaseAnalytics.instance;
  return AnalyticsServiceImpl(analytics);
});
