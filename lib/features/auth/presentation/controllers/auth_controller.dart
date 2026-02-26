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
        _handleDemoLogin(username, password); // ✅ مرّر الباسورد
      } else {
        await _handleRealLogin(username, password);
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleDemoLogin(String username, String password) {
    final box = GetStorage();

    final u = username.trim().toLowerCase();
    final p = password.trim();

    // Student demo account
    if (u == 'student' && p == '1234') {
      box.write('user_role', 'student');
      Get.offAllNamed(Routes.EXAM_DETAILS);
      return;
    }

    // Instructor demo account
    if (u == 'instructor' && p == '1234') {
      box.write('user_role', 'instructor');
      Get.offAllNamed(Routes.INSTRUCTOR_DASHBOARD);
      return;
    }

    // Developer demo account
    if (u == 'developer' && p == 'dev123') {
      box.write('user_role', 'developer');
      Get.offAllNamed(Routes.DEVELOPER_DASHBOARD);
      return;
    }

    Get.snackbar(
      'Error',
      'بيانات الدخول غلط (Demo).\n'
          'جرّب:\n'
          'student / 1234\n'
          'instructor / 1234\n'
          'developer / dev123',
    );
  }

  Future<void> _handleRealLogin(String username, String password) async {
    // Real JWT logic would go here
    throw UnimplementedError(
      'Real authentication not implemented in this demo package.',
    );
  }
}
