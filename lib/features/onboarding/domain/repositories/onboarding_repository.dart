abstract class OnboardingRepository {
  Future<bool> checkOnboardingStatus();
  Future<void> completeOnboarding();
}
