import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/welcome_controller.dart';

class LanguageSelectorWidget extends GetView<WelcomeController> {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF005BBF);
    const activeBgColor = Color(0xFFEFF6FF); // Light blue tint
    const inactiveBorderColor = Color(0xFFE2E8F0);
    const inactiveBgColor = Color(0xFFF8FAFC);

    return Obx(() {
      final String selected = controller.selectedLanguage.value;

      return Row(
        children: [
          // Arabic Selection Button
          Expanded(
            child: GestureDetector(
              onTap: () => controller.changeLanguage('ar'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 80,
                decoration: BoxDecoration(
                  color: selected == 'ar' ? activeBgColor : inactiveBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected == 'ar' ? activeColor : inactiveBorderColor,
                    width: selected == 'ar' ? 2 : 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.public_rounded,
                      color: selected == 'ar' ? activeColor : const Color(0xFF64748B),
                      size: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'العربية',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 14,
                        fontWeight: selected == 'ar' ? FontWeight.bold : FontWeight.normal,
                        color: selected == 'ar' ? activeColor : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // English Selection Button
          Expanded(
            child: GestureDetector(
              onTap: () => controller.changeLanguage('en'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 80,
                decoration: BoxDecoration(
                  color: selected == 'en' ? activeBgColor : inactiveBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selected == 'en' ? activeColor : inactiveBorderColor,
                    width: selected == 'en' ? 2 : 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.translate_rounded,
                      color: selected == 'en' ? activeColor : const Color(0xFF64748B),
                      size: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'English',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 14,
                        fontWeight: selected == 'en' ? FontWeight.bold : FontWeight.normal,
                        color: selected == 'en' ? activeColor : const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
