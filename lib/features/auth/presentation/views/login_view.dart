import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login/login_header_section.dart';
import '../widgets/login/login_form.dart';
import '../widgets/login/login_submit_button.dart';
import '../widgets/login/biometric_login_button.dart';
import '../widgets/login/login_footer.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);
    const slateBg = Color(0xFFF8FAFC); // Light grayish-blue canvas background

    final usernameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isAr = Get.locale?.languageCode == 'ar';

    void submit() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (!(formKey.currentState?.validate() ?? false)) return;
      controller.login(usernameCtrl.text, passwordCtrl.text);
    }

    return Scaffold(
      backgroundColor: slateBg,
      appBar: AppBar(
        backgroundColor: slateBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            isAr ? Icons.arrow_forward : Icons.arrow_back,
            color: textDark,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'login'.tr,
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'EduAssess AI',
                style: GoogleFonts.ibmPlexSans(
                  color: primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Smooth entry animation for the main Card
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 40 * (1.0 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Badge & Welcome Greetings
                          const LoginHeaderSection(),
                          const SizedBox(height: 24),

                          // Login Input Fields Form
                          LoginForm(
                            usernameCtrl: usernameCtrl,
                            passwordCtrl: passwordCtrl,
                            formKey: formKey,
                            onSubmit: submit,
                          ),
                          const SizedBox(height: 20),

                          // Submit Action Button
                          Obx(() => LoginSubmitButton(
                                loading: controller.isLoading.value,
                                onPressed: submit,
                              )),
                          const SizedBox(height: 24),

                          // Or separator
                          Row(
                            children: [
                              const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'or_continue_with'.tr,
                                  style: GoogleFonts.notoKufiArabic(
                                    color: const Color(0xFF94A3B8),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Biometric Login Button
                          BiometricLoginButton(
                            onTap: () => controller.login('student', '1234'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Redirect link footer
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
