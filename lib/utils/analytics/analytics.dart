import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:travel_exchanger/domain/currency.dart';

final analyticsVar = Analytics();

final class Analytics {
  final _analytics = FirebaseAnalytics.instance;

  Future<void> logAppOpen() {
    return _analytics.logAppOpen();
  }

  Future<void> logCustomTimeRate(
    Currency to,
    double perHour,
  ) {
    return _analytics.logEvent(
      name: AnalyticsEvent.customTimeRate.name,
      parameters: {
        'to': to.code,
        'perHour': perHour,
      },
    );
  }
}

enum AnalyticsEvent {
  customTimeRate,
}
