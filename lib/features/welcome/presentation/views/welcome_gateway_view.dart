import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/welcome_controller.dart';
import '../widgets/gateway_illustration.dart';

class WelcomeGatewayView extends GetView<WelcomeController> {
  const WelcomeGatewayView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const secondaryBg = Color(0xFFF1F5F9); // Light slate grey
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final bool loading = controller.isLoading.value;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Brand Illustration
                    const Center(child: GatewayIllustration()),
                    const SizedBox(height: 16),

                    // App Title
                    Text(
                      'EduAssess AI',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSans(
                        color: primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Greeting Headlines
                    Text(
                      'مرحباً بك في إيدو أسيس',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoKufiArabic(
                        color: textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'منصة التقييم الذكية المدعومة بالذكاء الاصطناعي لمستقبل تعليمي أفضل.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF64748B),
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Action Buttons (Login & Register)
                    if (loading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                      )
                    else ...[
                      // Login button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(Routes.LOGIN),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.login_rounded, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'تسجيل الدخول',
                                style: GoogleFonts.notoKufiArabic(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () => Get.toNamed(Routes.REGISTER),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: secondaryBg,
                            foregroundColor: primaryColor,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.person_add_alt_1_rounded, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'إنشاء حساب جديد',
                                style: GoogleFonts.notoKufiArabic(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Divider: "أو المتابعة عبر"
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'أو المتابعة عبر',
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

                    // Social logins
                    Row(
                      children: [
                        // Google Login
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton(
                              onPressed: loading ? null : () => controller.handleSocialSignIn('جوجل'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.g_mobiledata_rounded, color: Colors.redAccent, size: 26),
                                  const SizedBox(width: 4),
                                  Text(
                                    'جوجل',
                                    style: GoogleFonts.notoKufiArabic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Apple Login
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton(
                              onPressed: loading ? null : () => controller.handleSocialSignIn('أبل'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.apple, color: Colors.black87, size: 22),
                                  const SizedBox(width: 6),
                                  Text(
                                    'أبل',
                                    style: GoogleFonts.notoKufiArabic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                    const SizedBox(height: 36),

                    // Bottom links: Choose role / Change language
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Change language
                        TextButton.icon(
                          onPressed: () => Get.toNamed(Routes.WELCOME_SETUP),
                          icon: const Icon(Icons.language_rounded, color: primaryColor, size: 20),
                          label: Text(
                            'تغيير اللغة',
                            style: GoogleFonts.notoKufiArabic(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Choose Role
                        TextButton.icon(
                          onPressed: () => Get.toNamed(Routes.WELCOME_SETUP),
                          icon: const Icon(Icons.supervised_user_circle_rounded, color: primaryColor, size: 20),
                          label: Text(
                            'اختيار الدور',
                            style: GoogleFonts.notoKufiArabic(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Privacy disclaimers
                    Text(
                      'بالمتابعة، أنت توافق على شروط الخدمة وسياسة الخصوصية الخاصة بنا.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF94A3B8),
                        fontSize: 10,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
