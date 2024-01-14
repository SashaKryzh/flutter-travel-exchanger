import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_exchanger/domain/rate.dart';

part 'rates.freezed.dart';
part 'rates.g.dart';

@freezed
class GetRatesResponse with _$GetRatesResponse {
  factory GetRatesResponse({
    required bool success,
    required String base,
    required List<Rate> rates,
  }) = _GetRatesResponse;

  factory GetRatesResponse.fromJson(Map<String, dynamic> json) => _$GetRatesResponseFromJson(json);
}
