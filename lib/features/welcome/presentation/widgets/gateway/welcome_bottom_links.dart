import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../routes/app_routes.dart';

class WelcomeBottomLinks extends StatelessWidget {
  const WelcomeBottomLinks({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Change language
        TextButton.icon(
          onPressed: () => Get.toNamed(Routes.WELCOME_SETUP),
          icon: const Icon(Icons.language_rounded, color: primaryColor, size: 20),
          label: Text(
            'change_language'.tr,
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
            'choose_role'.tr,
            style: GoogleFonts.notoKufiArabic(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
