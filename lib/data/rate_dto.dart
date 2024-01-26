import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';

part 'rate_dto.freezed.dart';
part 'rate_dto.g.dart';

@freezed
class RateDto with _$RateDto {
  const RateDto._();
  
  factory RateDto({
    required String base,
    required String target,
    required double rate,
    required DateTime updatedAt,
  }) = _RateDto;

  factory RateDto.fromJson(Map<String, dynamic> json) => _$RateDtoFromJson(json);

  Rate toDomain({RateSource source = RateSource.api}) {
    return Rate(
      base: Currency(code: base),
      target: Currency(code: target),
      rate: rate,
      updatedAt: updatedAt,
      source: source,
    );
  }
}
