import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'onboarding_repository.g.dart';

@riverpod
OnboardingRepository onboardingRepository(OnboardingRepositoryRef ref) {
  return OnboardingRepository(ref.watch(sharedPreferencesProvider));
}

class OnboardingRepository {
  static const _onboardingAtKey = 'onboardingAt';

  const OnboardingRepository(this._storage);

  final SharedPreferences _storage;

  Future<void> storeOnboardingComplete() async {
    await _storage.setString(_onboardingAtKey, DateTime.now().toIso8601String());
  }

  Future<bool> isOnboardingComplete() async {
    try {
      final s = _storage.getString(_onboardingAtKey);
      return s != null;
    } catch (e, stackTrace) {
      logError(
        'Parsing onboarding timestamp error',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
