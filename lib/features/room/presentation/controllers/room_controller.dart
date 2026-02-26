import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class RoomController extends GetxController {
  var isLoading = false.obs;

  Future<void> joinRoom(String code) async {
    isLoading.value = true;
    try {
      // Simulation
      Get.toNamed(Routes.EXAM);
    } finally {
      isLoading.value = false;
    }
  }
}
