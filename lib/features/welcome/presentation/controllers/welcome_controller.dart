import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/welcome_config_entity.dart';
import '../../domain/usecases/get_welcome_config.dart';
import '../../domain/usecases/save_welcome_config.dart';
import '../../../../core/controllers/settings_controller.dart';

class WelcomeController extends GetxController {
  final GetWelcomeConfig getWelcomeConfigUseCase;
  final SaveWelcomeConfig saveWelcomeConfigUseCase;

  WelcomeController({
    required this.getWelcomeConfigUseCase,
    required this.saveWelcomeConfigUseCase,
  });

  final RxString selectedLanguage = 'ar'.obs;
  final RxString selectedRole = 'student'.obs; // 'student' or 'instructor'
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final config = await getWelcomeConfigUseCase();
    if (config != null) {
      selectedLanguage.value = config.languageCode;
      selectedRole.value = config.role;
      try {
        final settingsController = Get.find<SettingsController>();
        settingsController.changeLanguage(config.languageCode);
      } catch (_) {
        Get.updateLocale(Locale(config.languageCode));
      }
    }
  }

  void changeLanguage(String langCode) {
    selectedLanguage.value = langCode;
    try {
      final settingsController = Get.find<SettingsController>();
      settingsController.changeLanguage(langCode);
    } catch (_) {
      Get.updateLocale(Locale(langCode));
    }
  }

  void changeRole(String role) {
    selectedRole.value = role;
  }

  Future<void> saveSettings() async {
    final config = WelcomeConfigEntity(
      languageCode: selectedLanguage.value,
      role: selectedRole.value,
    );
    await saveWelcomeConfigUseCase(config);
  }

  Future<void> handleSocialSignIn(String provider) async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      
      // Persist preferences
      await saveSettings();

      final String role = selectedRole.value;
      if (role == 'student') {
        Get.offAllNamed(Routes.EXAM_DETAILS);
      } else if (role == 'instructor') {
        Get.offAllNamed(Routes.INSTRUCTOR_DASHBOARD);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
      
      Get.snackbar(
        'تم تسجيل الدخول',
        'مرحباً بك! تم الدخول عبر $provider كـ ${role == 'student' ? 'طالب' : 'معلم'}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Sign-in failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
