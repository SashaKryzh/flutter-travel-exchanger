import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/config/i18n/strings.g.dart';

part 'strings_providers.g.dart';

@riverpod
Stream<AppLocale> appLocaleStream(AppLocaleStreamRef _) {
  return LocaleSettings.getLocaleStream();
}

@riverpod
Translations t(TRef ref) {
  ref.watch(appLocaleStreamProvider);
  return LocaleSettings.currentLocale.translations;
}
