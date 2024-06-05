import 'package:dart_mappable/dart_mappable.dart';

part 'terms_of_use_config.mapper.dart';

@MappableClass()
class TermsOfUseConfig with TermsOfUseConfigMappable {
  TermsOfUseConfig({
    required this.url,
  });

  final String url;
}
