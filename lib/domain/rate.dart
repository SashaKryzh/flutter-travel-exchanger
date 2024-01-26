import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'rate.freezed.dart';
part 'rate.g.dart';

@freezed
class Rate with _$Rate {
  factory Rate({
    required Currency base,
    required Currency target,
    required double rate,
    required DateTime updatedAt,
    required RateSource source,
  }) = _Rate;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
}

enum RateSource {
  api,
  custom,
}
