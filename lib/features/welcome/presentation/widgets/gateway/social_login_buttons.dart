import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/welcome_controller.dart';

class SocialLoginButtons extends StatelessWidget {
  final WelcomeController controller;
  final bool loading;

  const SocialLoginButtons({
    super.key,
    required this.controller,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);

    return Row(
      children: [
        // Google Login
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton(
              onPressed: loading ? null : () => controller.handleSocialSignIn('google'.tr),
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
                    'google'.tr,
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
              onPressed: loading ? null : () => controller.handleSocialSignIn('apple'.tr),
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
                    'apple'.tr,
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
    );
  }
}
