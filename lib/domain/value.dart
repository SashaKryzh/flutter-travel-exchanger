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
      return '${duration.inSeconds}s';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inDays < 30) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inDays < 365) {
      return '${duration.inDays ~/ 30}mo ${duration.inDays % 30}d';
    } else if (duration.inDays < 365 * 10) {
      final months = duration.inDays % 365 ~/ 30;
      return '${duration.inDays ~/ 365}y ${months}mo';
    } else {
      return '${duration.inDays ~/ 365}y';
    }
  }
}
