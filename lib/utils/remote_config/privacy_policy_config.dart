import 'package:dart_mappable/dart_mappable.dart';

part 'privacy_policy_config.mapper.dart';

@MappableClass()
class PrivacyPolicyConfig with PrivacyPolicyConfigMappable {
  PrivacyPolicyConfig({
    required this.url,
  });

  final String url;
}
