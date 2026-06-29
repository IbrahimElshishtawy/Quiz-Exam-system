import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Center blue rounded square box with cap icon
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // Soft blue tint background
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: primaryColor,
              size: 44,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Bold welcome back text
        Text(
          'welcome_back'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textDark,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle instructions
        Text(
          'sign_in_continue'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF64748B),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
