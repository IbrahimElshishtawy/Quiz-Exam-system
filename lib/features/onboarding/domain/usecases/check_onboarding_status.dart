import '../repositories/onboarding_repository.dart';

class CheckOnboardingStatus {
  final OnboardingRepository repository;

  CheckOnboardingStatus(this.repository);

  Future<bool> call() async {
    return await repository.checkOnboardingStatus();
  }
}
