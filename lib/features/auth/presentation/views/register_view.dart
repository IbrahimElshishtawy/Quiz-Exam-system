import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    final isPasswordHidden = true.obs;
    final isConfirmPasswordHidden = true.obs;
    final agreeToTerms = false.obs;

    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);
    final isAr = Get.locale?.languageCode == 'ar';

    void submit() {
      FocusManager.instance.primaryFocus?.unfocus();

      if (!(formKey.currentState?.validate() ?? false)) return;

      if (!agreeToTerms.value) {
        Get.snackbar(
          'alert'.tr,
          'terms_error'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
        return;
      }

      controller.register(nameCtrl.text, emailCtrl.text, passCtrl.text);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            isAr ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
            color: primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'create_account'.tr,
          style: GoogleFonts.notoKufiArabic(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 600),
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1.0 - value)),
                      child: child,
                    ),
                  );
                },
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // School cap Logo
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.25),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Greetings
                      Text(
                        'register_title'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoKufiArabic(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'register_subtitle'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoKufiArabic(
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Full Name Field
                      TextFormField(
                        controller: nameCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'full_name'.tr,
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'enter_full_name'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Email Field
                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'email'.tr,
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'enter_email'.tr;
                          }
                          if (!v.contains('@') || !v.contains('.')) {
                            return 'invalid_email'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Password Field
                      Obx(
                        () => TextFormField(
                          controller: passCtrl,
                          obscureText: isPasswordHidden.value,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'password'.tr,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => isPasswordHidden.toggle(),
                              icon: Icon(
                                isPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'enter_password_reg'.tr;
                            }
                            if (v.trim().length < 6) {
                              return 'password_short_reg'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Confirm Password Field
                      Obx(
                        () => TextFormField(
                          controller: confirmPassCtrl,
                          obscureText: isConfirmPasswordHidden.value,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => submit(),
                          decoration: InputDecoration(
                            hintText: 'confirm_password'.tr,
                            prefixIcon: const Icon(Icons.shield_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => isConfirmPasswordHidden.toggle(),
                              icon: Icon(
                                isConfirmPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'enter_confirm_password'.tr;
                            }
                            if (v != passCtrl.text) {
                              return 'passwords_dont_match'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Terms Agreement Checkbox (Layout direction adapted)
                      Obx(
                        () => Row(
                          mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: isAr
                              ? [
                                  Text(
                                    'agree_to_terms'.tr,
                                    style: GoogleFonts.notoKufiArabic(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Checkbox(
                                    value: agreeToTerms.value,
                                    onChanged: (v) => agreeToTerms.value = v ?? false,
                                    activeColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ]
                              : [
                                  Checkbox(
                                    value: agreeToTerms.value,
                                    onChanged: (v) => agreeToTerms.value = v ?? false,
                                    activeColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Text(
                                    'agree_to_terms'.tr,
                                    style: GoogleFonts.notoKufiArabic(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Register button
                      Obx(() {
                        final bool loading = controller.isLoading.value;

                        return SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: loading ? null : submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            child: loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isAr ? Icons.arrow_back : Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'create_account'.tr,
                                        style: GoogleFonts.notoKufiArabic(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      }),
                      const SizedBox(height: 24),

                      // Separator: "أو سجل عبر"
                      Row(
                        children: [
                          const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'or_register_via'.tr,
                              style: GoogleFonts.notoKufiArabic(
                                color: const Color(0xFF94A3B8),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Social Logins (Google & Apple)
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () => controller.login('student', '1234'),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Text(
                                  'GOOGLE',
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () => controller.login('student', '1234'),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.face_retouching_natural_rounded,
                                      color: Colors.blueAccent,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'apple'.tr,
                                      style: GoogleFonts.notoKufiArabic(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Redirect to Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.offNamed(Routes.LOGIN),
                            child: Text(
                              'login'.tr,
                              style: GoogleFonts.notoKufiArabic(
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'already_have_account'.tr,
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Footer copyright
                      Text(
                        'copyright'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoKufiArabic(
                          color: const Color(0xFF94A3B8),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
