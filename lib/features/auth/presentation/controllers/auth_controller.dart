import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/config/app_config.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      if (AppConfig.isDemoMode) {
        _handleDemoLogin(username);
      } else {
        await _handleRealLogin(username, password);
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleDemoLogin(String username) {
    final box = GetStorage();
    if (username == 'student') {
      box.write('user_role', 'student');
      Get.offAllNamed(Routes.EXAM_DETAILS);
    } else {
      box.write('user_role', 'instructor');
      Get.offAllNamed(Routes.INSTRUCTOR_DASHBOARD);
    }
  }

  Future<void> _handleRealLogin(String username, String password) async {
    // Real JWT logic would go here
    // For now, if not in demo mode, we just fail or point to real implementation
    throw UnimplementedError('Real authentication not implemented in this demo package.');
  }
}
