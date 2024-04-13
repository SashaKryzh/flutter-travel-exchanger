import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:travel_exchanger/utils/remote_config/feedback_form_config.dart';
import 'package:travel_exchanger/utils/remote_config/x_profile_config.dart';

final remoteConfig = RemoteConfig();

final class RemoteConfig {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _remoteConfig.setDefaults(_remoteConfigDefaults);
    await _remoteConfig.fetchAndActivate();
  }

  FeedbackFormConfig getFeedbackFormConfig() {
    final string = _remoteConfig.getString(RemoteConfigKeys.feedbackForm);
    return FeedbackFormConfigMapper.fromJson(string);
  }

  XProfileConfig getXProfileConfig() {
    final string = _remoteConfig.getString(RemoteConfigKeys.xProfile);
    return XProfileConfigMapper.fromJson(string);
  }
}

final class RemoteConfigKeys {
  static const feedbackForm = 'feedback_form';
  static const xProfile = 'x_profile';
}

final _remoteConfigDefaults = {
  RemoteConfigKeys.feedbackForm: const FeedbackFormConfig(
    url: 'https://forms.gle/nyQH611rGg5mPyXFA',
  ).toJson(),
  RemoteConfigKeys.xProfile: XProfileConfig(
    username: '@sashakryzh',
    url: 'https://twitter.com/sashakryzh',
  ).toJson(),
};
