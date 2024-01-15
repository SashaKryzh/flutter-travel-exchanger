import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'exchange_between_repository.g.dart';

@riverpod
ExchangeBetweenRepository exchangeBetweenRepository(ExchangeBetweenRepositoryRef ref) {
  return ExchangeBetweenRepository(ref.watch(sharedPreferencesProvider));
}

class ExchangeBetweenRepository {
  static const _key = 'exchangeBetween';

  const ExchangeBetweenRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Between? getExchangeBetween() {
    final string = _sharedPreferences.getString(_key);
    if (string == null) {
      return null;
    }
    return _decode(string);
  }

  Future<void> setExchangeBetween(Between between) async {
    await _sharedPreferences.setString(_key, _encode(between));
  }

  Future<void> clear() async {
    await _sharedPreferences.remove(_key);
  }

  String _encode(Between between) {
    return '${between.$1.code}-${between.$2.code}${between.$3 != null ? '-${between.$3!.code}' : ''}';
  }

  Between _decode(String string) {
    final split = string.split('-');
    return (
      Currency(code: split[0]),
      Currency(code: split[1]),
      split.length == 3 ? Currency(code: split[2]) : null,
    );
  }
}
