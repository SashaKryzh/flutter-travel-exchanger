import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:travel_exchanger/utils/remote_config/feedback_form_config.dart';
import 'package:travel_exchanger/utils/remote_config/privacy_policy_config.dart';
import 'package:travel_exchanger/utils/remote_config/terms_of_use_config.dart';
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

  PrivacyPolicyConfig getPrivacyPolicyConfig() {
    final string = _remoteConfig.getString(RemoteConfigKeys.privacyPolicy);
    return PrivacyPolicyConfigMapper.fromJson(string);
  }

  TermsOfUseConfig getTermsOfUseConfig() {
    final string = _remoteConfig.getString(RemoteConfigKeys.termsOfUse);
    return TermsOfUseConfigMapper.fromJson(string);
  }
}

final class RemoteConfigKeys {
  static const feedbackForm = 'feedback_form';
  static const xProfile = 'x_profile';
  static const privacyPolicy = 'privacy_policy';
  static const termsOfUse = 'terms_of_use';
}

final _remoteConfigDefaults = {
  RemoteConfigKeys.feedbackForm: const FeedbackFormConfig(
    url: 'https://forms.gle/nyQH611rGg5mPyXFA',
  ).toJson(),
  RemoteConfigKeys.xProfile: XProfileConfig(
    username: '@sashakryzh',
    url: 'https://twitter.com/sashakryzh',
  ).toJson(),
  RemoteConfigKeys.privacyPolicy: PrivacyPolicyConfig(
    url: 'https://sashakryzh.notion.site/Privacy-Policy-7f6c0af1a21643438e14d445fb0baf40',
  ).toJson(),
  RemoteConfigKeys.termsOfUse: TermsOfUseConfig(
    url: 'https://sashakryzh.notion.site/Terms-of-Use-6f3215b7e83f4d27984765c6f9f4438e',
  ).toJson(),
};
