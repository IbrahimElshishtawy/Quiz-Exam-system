import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../routes/app_routes.dart';

class WelcomeActionButtons extends StatelessWidget {
  final bool loading;
  const WelcomeActionButtons({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const secondaryBg = Color(0xFFF1F5F9); // Light slate grey

    if (loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: CircularProgressIndicator(color: primaryColor),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                  'login'.tr,
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

        // Register button
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
                  'register'.tr,
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
    );
  }
}
