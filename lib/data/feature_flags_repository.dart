import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';

part 'feature_flags_repository.g.dart';

@riverpod
FeatureFlagsRepository featureFlagsRepository(FeatureFlagsRepositoryRef ref) {
  return FeatureFlagsRepository(ref.watch(sharedPreferencesProvider));
}

class FeatureFlagsRepository {
  FeatureFlagsRepository(this._sharedPreferences);

  // ignore: unused_field
  final SharedPreferences _sharedPreferences;
}
