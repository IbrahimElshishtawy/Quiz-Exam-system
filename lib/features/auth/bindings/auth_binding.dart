import 'package:get/get.dart';
import '../presentation/controllers/auth_controller.dart';
import '../../../../core/network/dio_client.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DioClient());
    Get.lazyPut(() => AuthController(Get.find<DioClient>()));
  }
}
