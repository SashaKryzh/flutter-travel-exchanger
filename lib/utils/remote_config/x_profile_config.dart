import 'package:dart_mappable/dart_mappable.dart';

part 'x_profile_config.mapper.dart';

@MappableClass()
class XProfileConfig with XProfileConfigMappable {
  XProfileConfig({
    required this.username,
    required this.url,
  });

  final String username;
  final String url;
}
