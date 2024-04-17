import 'package:intl/intl.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/currency_input_formatter.dart';
import 'package:travel_exchanger/utils/time_currency_utils.dart';

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
    final formatter = NumberFormat.compact();
    return formatter.format(value);
  }

  String formatM({
    bool showFullNumber = false,
    bool truncateDecimal = false,
    bool roundFractionDigits = false,
  }) {
    final escapedDecimalSeparator = RegExp.escape(decimalSeparator);
    final regexPattern = '($escapedDecimalSeparator' '0+|(?<=$escapedDecimalSeparator\\d+)0+)\$';

    if (showFullNumber) {
      final s = formatMoney(value);
      return truncateDecimal ? s.replaceAll(RegExp(regexPattern), '') : s;
    }

    if (value < thousand) {
      final s = formatMoney(value, decimalDigits: roundFractionDigits && value > 1 ? 1 : 2);
      return truncateDecimal ? s.replaceAll(RegExp(regexPattern), '') : s;
    }

    final double newValue;
    final String suffix;

    if (value < million) {
      suffix = 'K';
      newValue = value / thousand;
    } else if (value < billion) {
      suffix = 'M';
      newValue = value / million;
    } else if (value < trillion) {
      suffix = 'B';
      newValue = value / billion;
    } else {
      suffix = 'T';
      newValue = value / trillion;
    }

    return "${formatMoney(newValue).replaceAll(RegExp(regexPattern), "")}$suffix";
  }
}

const thousand = 1000;
const million = 1000000;
const billion = 1000000000;
const trillion = 1000000000000;

class TimeValue extends Value {
  const TimeValue(double hours) : super._(hours, Currency.time);

  factory TimeValue.fromMinutes(double minutes) {
    return TimeValue(minutes / kMinutesInHour);
  }

  factory TimeValue.fromDays(double days) {
    return TimeValue(days * kHoursInDay);
  }

  @override
  String format() {
    final duration = Duration(seconds: (value * kSecondsInHour).toInt());
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds}s';
    } else if (duration.inMinutes < 60) {
      final seconds = duration.inSeconds % 60;
      return '${duration.inMinutes}m${seconds > 0 ? ' ${seconds}s' : ''}';
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
