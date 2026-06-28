import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepIndicator extends StatelessWidget {
  final int activeIndex; // 0, 1, 2

  const StepIndicator({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const inactiveColor = Color(0xFFE2E8F0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          // Step 3
          Expanded(
            child: _buildStepItem(
              index: 2,
              title: 'الأسئلة',
              isActive: activeIndex >= 2,
              isCompleted: false,
            ),
          ),
          _buildLine(activeIndex >= 2),

          // Step 2
          Expanded(
            child: _buildStepItem(
              index: 1,
              title: 'الإعدادات',
              isActive: activeIndex >= 1,
              isCompleted: activeIndex > 1,
            ),
          ),
          _buildLine(activeIndex >= 1),

          // Step 1
          Expanded(
            child: _buildStepItem(
              index: 0,
              title: 'التفاصيل',
              isActive: activeIndex >= 0,
              isCompleted: activeIndex > 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required int index,
    required String title,
    required bool isActive,
    required bool isCompleted,
  }) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bubble
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: isCompleted
                ? primaryColor
                : isActive
                    ? primaryColor
                    : const Color(0xFFF1F5F9),
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? primaryColor : const Color(0xFFCBD5E1),
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: isCompleted
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : Text(
                  '${index + 1}',
                  style: GoogleFonts.ibmPlexSans(
                    color: isActive ? Colors.white : const Color(0xFF64748B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoKufiArabic(
            color: isActive ? primaryColor : const Color(0xFF64748B),
            fontSize: 10.5,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool passed) {
    return Expanded(
      child: Container(
        height: 3,
        margin: const EdgeInsets.only(bottom: 24),
        color: passed ? const Color(0xFF005BBF) : const Color(0xFFE2E8F0),
      ),
    );
  }
}
