import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/utils/logger.dart';

class MyProviderObserver extends ProviderObserver {
  const MyProviderObserver();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    return switch (newValue) {
      AsyncError() => logError(provider, newValue),
      _ => null,
    };
  }

  void logError(ProviderBase<Object?> provider, AsyncError<dynamic> error) => logger.d('''
{
  Provider: "${provider.name ?? provider.runtimeType}",
  Error: "${error.error}",
  Stacktrace: ${error.stackTrace.toString().split('\n').take(10).join('\n')}\n...
}''');
}
