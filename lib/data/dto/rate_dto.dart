import 'package:dart_mappable/dart_mappable.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';

part 'rate_dto.mapper.dart';

@MappableClass()
class RateDto with RateDtoMappable {
  const RateDto({
    required this.base,
    required this.target,
    required this.rate,
  });

  final String base;
  final String target;
  final double rate;

  Rate toDomain({RateSource source = RateSource.api}) {
    return Rate(
      from: Currency(base),
      to: Currency(target),
      rate: rate,
      source: source,
    );
  }
}
