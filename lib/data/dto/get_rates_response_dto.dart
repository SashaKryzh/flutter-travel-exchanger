import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_exchanger/data/dto/rate_dto.dart';

part 'get_rates_response_dto.freezed.dart';
part 'get_rates_response_dto.g.dart';

@freezed
class GetRatesResponseDto with _$GetRatesResponseDto {
  factory GetRatesResponseDto({
    required bool success,
    required String base,
    required List<RateDto> rates,
  }) = _GetRatesResponseDto;

  factory GetRatesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetRatesResponseDtoFromJson(json);
}
