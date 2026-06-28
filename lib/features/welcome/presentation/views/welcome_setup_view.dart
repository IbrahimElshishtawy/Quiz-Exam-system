import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/welcome_controller.dart';
import '../widgets/language_selector_widget.dart';
import '../widgets/role_card_widget.dart';
import '../widgets/setup_illustration.dart';
import '../widgets/setup/setup_header_section.dart';
import '../widgets/setup/setup_continue_button.dart';

class WelcomeSetupView extends GetView<WelcomeController> {
  const WelcomeSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Skip',
            style: GoogleFonts.ibmPlexSans(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          'EduAssess AI',
          style: GoogleFonts.ibmPlexSans(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_rounded, color: primaryColor),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Logo & Headings
                    const SetupHeaderSection(),
                    const SizedBox(height: 28),

                    // Language Selection Section
                    Text(
                      'اختر اللغة',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const LanguageSelectorWidget(),
                    const SizedBox(height: 24),

                    // Role Selection Section
                    Text(
                      'اختر دورك',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      final String currentRole = controller.selectedRole.value;

                      return Column(
                        children: [
                          RoleCardWidget(
                            title: 'طالب (Student)',
                            subtitle: 'الوصول إلى الاختبارات والنتائج',
                            icon: Icons.person_rounded,
                            roleValue: 'student',
                            selectedRole: currentRole,
                            onTap: () => controller.changeRole('student'),
                          ),
                          const SizedBox(height: 12),
                          RoleCardWidget(
                            title: 'معلم (Teacher)',
                            subtitle: 'إدارة الاختبارات والتقييمات',
                            icon: Icons.psychology_rounded,
                            roleValue: 'instructor',
                            selectedRole: currentRole,
                            onTap: () => controller.changeRole('instructor'),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),

                    // Custom illustration at bottom
                    const SetupIllustration(),
                  ],
                ),
              ),
            ),

            // Bottom Continue Action Button
            SetupContinueButton(
              onPressed: () async {
                await controller.saveSettings();
                Get.back();
                Get.snackbar(
                  'تم التخصيص',
                  'تم حفظ إعدادات التطبيق بنجاح.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: primaryColor,
                  colorText: Colors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
