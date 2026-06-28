import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../gateway_illustration.dart';

class WelcomeTitleSection extends StatelessWidget {
  const WelcomeTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
      ],
    );
  }
}
