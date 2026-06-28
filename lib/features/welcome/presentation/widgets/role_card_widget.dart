import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String roleValue;
  final String selectedRole;
  final VoidCallback onTap;

  const RoleCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.roleValue,
    required this.selectedRole,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedRole == roleValue;
    const activeColor = Color(0xFF005BBF);
    const activeBgColor = Color(0xFFEFF6FF);
    const inactiveBorderColor = Color(0xFFE2E8F0);
    const inactiveBgColor = Color(0xFFF8FAFC);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : inactiveBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? activeColor : inactiveBorderColor,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            // Text Details (Title, Description)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? activeColor : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Icon Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor.withOpacity(0.12)
                    : const Color(0xFFCBD5E1).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? activeColor : const Color(0xFF64748B),
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
