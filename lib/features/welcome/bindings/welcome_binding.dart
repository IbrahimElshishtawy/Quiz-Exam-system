import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/datasources/welcome_local_datasource.dart';
import '../data/repositories/welcome_repository_impl.dart';
import '../domain/repositories/welcome_repository.dart';
import '../domain/usecases/get_welcome_config.dart';
import '../domain/usecases/save_welcome_config.dart';
import '../presentation/controllers/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    // Local Datasource
    Get.lazyPut<WelcomeLocalDataSource>(
      () => WelcomeLocalDataSourceImpl(GetStorage()),
    );

    // Repository implementation
    Get.lazyPut<WelcomeRepository>(
      () => WelcomeRepositoryImpl(localDataSource: Get.find()),
    );

    // Usecases
    Get.lazyPut(() => GetWelcomeConfig(Get.find()));
    Get.lazyPut(() => SaveWelcomeConfig(Get.find()));

    // Controller
    Get.lazyPut(
      () => WelcomeController(
        getWelcomeConfigUseCase: Get.find(),
        saveWelcomeConfigUseCase: Get.find(),
      ),
    );
  }
}
