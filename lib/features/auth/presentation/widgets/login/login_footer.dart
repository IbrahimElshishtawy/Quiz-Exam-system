import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../routes/app_routes.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.REGISTER),
          child: Text(
            'register'.tr,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 13.5,
              color: primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'no_account_yet'.tr,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 13.5,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
