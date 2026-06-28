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
        Expanded(
          child: TextButton.icon(
            onPressed: () => Get.toNamed(Routes.WELCOME_SETUP),
            icon: const Icon(Icons.language_rounded, color: primaryColor, size: 18),
            label: Text(
              'change_language'.tr,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.notoKufiArabic(
                color: primaryColor,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Choose Role
        Expanded(
          child: TextButton.icon(
            onPressed: () => Get.toNamed(Routes.WELCOME_SETUP),
            icon: const Icon(Icons.supervised_user_circle_rounded, color: primaryColor, size: 18),
            label: Text(
              'choose_role'.tr,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.notoKufiArabic(
                color: primaryColor,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
