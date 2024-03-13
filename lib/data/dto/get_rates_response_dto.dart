import 'package:dart_mappable/dart_mappable.dart';
import 'package:travel_exchanger/data/dto/rate_dto.dart';

part 'get_rates_response_dto.mapper.dart';

@MappableClass()
class GetRatesResponseDto with GetRatesResponseDtoMappable {
  const GetRatesResponseDto({
    required this.success,
    required this.updatedAt,
    required this.base,
    required this.rates,
  });

  final bool success;
  final DateTime updatedAt;
  final String base;
  final List<RateDto> rates;
}
