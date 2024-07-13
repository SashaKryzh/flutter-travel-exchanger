import 'package:dart_mappable/dart_mappable.dart';

part 'feature_flags.mapper.dart';

const kEnableRecentCurrencies = false;
const kEnableClearAllData = false;

@MappableClass()
class FeatureFlags with FeatureFlagsMappable {
  const FeatureFlags(this.enableRecentlyUsed);

  final bool enableRecentlyUsed;
}
