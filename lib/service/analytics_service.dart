abstract interface class AnalyticsService {
  Future<void> logApiCall(String name, {Map<String, Object>? parameters});
}
