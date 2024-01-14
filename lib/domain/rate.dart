import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate.freezed.dart';
part 'rate.g.dart';

@freezed
class Rate with _$Rate {
  factory Rate({
    required String base,
    required String target,
    required double rate,
    required DateTime updatedAt,
  }) = _Rate;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
}
