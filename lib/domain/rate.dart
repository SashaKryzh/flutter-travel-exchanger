import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'rate.freezed.dart';
part 'rate.g.dart';

@freezed
class Rate with _$Rate {
  const Rate._();

  factory Rate({
    required Currency from,
    required Currency to,
    required double rate,
    required RateSource source,
  }) = _Rate;

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);

  @override
  bool operator ==(Object other) {
    if (other is Rate) {
      return from == other.from && to == other.to && source == other.source;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(from, to, source);
}

enum RateSource {
  api,
  custom;

  bool get isApi => this == RateSource.api;
  bool get isCustom => this == RateSource.custom;
}

@freezed
class RatesData with _$RatesData {
  const RatesData._();

  factory RatesData(
    DateTime updatedAt,
    Currency base,
    List<Rate> rates,
  ) = _RatesData;

  factory RatesData.fromJson(Map<String, dynamic> json) => _$RatesDataFromJson(json);
}

class RatesDataTimestamps extends Equatable {
  const RatesDataTimestamps({
    required this.updatedAt,
    required this.lastFetchedAt,
  });

  final DateTime updatedAt;
  final DateTime lastFetchedAt;

  @override
  List<Object?> get props => [updatedAt, lastFetchedAt];
}
