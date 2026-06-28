import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/welcome_controller.dart';
import '../widgets/gateway/welcome_title_section.dart';
import '../widgets/gateway/welcome_action_buttons.dart';
import '../widgets/gateway/social_login_buttons.dart';
import '../widgets/gateway/welcome_bottom_links.dart';

class WelcomeGatewayView extends GetView<WelcomeController> {
  const WelcomeGatewayView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    // Header Brand Illustration & Title
                    const WelcomeTitleSection(),
                    const SizedBox(height: 36),

                    // Action Buttons (Login & Register)
                    WelcomeActionButtons(loading: loading),
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
                    SocialLoginButtons(controller: controller, loading: loading),
                    const SizedBox(height: 36),

                    // Bottom links: Choose role / Change language
                    const WelcomeBottomLinks(),
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
