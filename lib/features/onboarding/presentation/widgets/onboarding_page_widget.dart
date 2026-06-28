import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/onboarding_page_entity.dart';
import 'onboarding_illustrations.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageEntity page;

  const OnboardingPageWidget({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Container Card
          _buildIllustration(page.index),
          const SizedBox(height: 36),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B), // Premium dark grey
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              page.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF64748B), // Slate secondary grey
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration(int index) {
    switch (index) {
      case 0:
        return const SecureExamIllustration();
      case 1:
        return const AIAnalyticsIllustration();
      case 2:
        return const AnywhereAnytimeIllustration();
      default:
        return const SizedBox.shrink();
    }
  }
}
