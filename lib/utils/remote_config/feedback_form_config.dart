import 'package:dart_mappable/dart_mappable.dart';

part 'feedback_form_config.mapper.dart';

@MappableClass()
class FeedbackFormConfig with FeedbackFormConfigMappable {
  const FeedbackFormConfig({
    required this.url,
  });

  final String url;
}
