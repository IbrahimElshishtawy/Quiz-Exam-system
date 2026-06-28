import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> checkOnboardingStatus() async {
    return await localDataSource.checkOnboardingStatus();
  }

  @override
  Future<void> completeOnboarding() async {
    await localDataSource.completeOnboarding();
  }
}
