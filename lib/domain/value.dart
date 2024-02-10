import 'package:travel_exchanger/domain/currency.dart';

sealed class Value {
  const Value._(this.value, this.currency);

  factory Value(double value, Currency currency) {
    if (currency == Currency.time) {
      return TimeValue(value);
    } else {
      return MoneyValue(value, currency);
    }
  }

  final double value;
  final Currency currency;

  String format();
}

class MoneyValue extends Value {
  const MoneyValue(super.value, super.currency) : super._();

  @override
  String format() {
    return value.toStringAsFixed(2);
  }
}

class TimeValue extends Value {
  const TimeValue(double value) : super._(value, Currency.time);

  @override
  String format() {
    final duration = Duration(seconds: value.toInt());
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds} sec';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} min ${duration.inSeconds % 60} sec';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} h ${duration.inMinutes % 60} min';
    } else {
      return '${duration.inDays} d ${duration.inHours % 24} h';
    }
  }
}
