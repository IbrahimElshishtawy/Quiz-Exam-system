import 'package:get_storage/get_storage.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> checkOnboardingStatus();
  Future<void> completeOnboarding();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final GetStorage storage;
  static const String _key = 'has_completed_onboarding';

  OnboardingLocalDataSourceImpl(this.storage);

  @override
  Future<bool> checkOnboardingStatus() async {
    return storage.read<bool>(_key) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    await storage.write(_key, true);
  }
}
