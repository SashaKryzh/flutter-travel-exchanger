import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/utils/analytics/analytics.dart';

part 'analytics_provider.g.dart';

@Riverpod(keepAlive: true)
Analytics analytics(AnalyticsRef ref) {
  return Analytics();
}
