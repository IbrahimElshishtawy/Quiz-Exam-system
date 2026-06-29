import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BiometricLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const BiometricLoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fingerprint_rounded,
              color: primaryColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'biometric_login'.tr,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
