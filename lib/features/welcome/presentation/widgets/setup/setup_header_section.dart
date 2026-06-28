import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupHeaderSection extends StatelessWidget {
  const SetupHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        // Small Cap Logo
        Center(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE), // Light blue-purple
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.school_rounded,
              color: primaryColor,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Headings
        Text(
          'customize_welcome'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'customize_subtitle'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
