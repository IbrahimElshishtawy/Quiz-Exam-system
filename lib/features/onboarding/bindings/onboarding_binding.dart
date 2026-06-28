import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/datasources/onboarding_local_datasource.dart';
import '../data/repositories/onboarding_repository_impl.dart';
import '../domain/repositories/onboarding_repository.dart';
import '../domain/usecases/complete_onboarding.dart';
import '../presentation/controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    // Local Datasource
    Get.lazyPut<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(GetStorage()),
    );

    // Repository implementation
    Get.lazyPut<OnboardingRepository>(
      () => OnboardingRepositoryImpl(localDataSource: Get.find()),
    );

    // Usecases
    Get.lazyPut(() => CompleteOnboarding(Get.find()));

    // Controller
    Get.lazyPut(
      () => OnboardingController(completeOnboardingUseCase: Get.find()),
    );
  }
}
