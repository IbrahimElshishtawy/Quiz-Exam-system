import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/instructor_exam_entity.dart';

class InstructorExamCard extends StatelessWidget {
  final InstructorExamEntity exam;

  const InstructorExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final bool isActive = exam.status == 'active';
    final bool isBiologyAlert = exam.id == 'ie3'; // biologists DNA alert badge

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // Left: Remaining Time or Duration
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.remainingTimeOrDuration,
                style: GoogleFonts.ibmPlexSans(
                  color: isActive
                      ? isBiologyAlert
                          ? const Color(0xFFEF4444)
                          : primaryColor
                      : const Color(0xFF64748B),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isActive ? 'المتبقي' : 'المدة',
                style: GoogleFonts.notoKufiArabic(
                  color: const Color(0xFF94A3B8),
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Center: Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Title
                Text(
                  exam.title,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    color: textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Specs metadata row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Alerts badge (Biology alert)
                    if (isBiologyAlert) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFFCA5A5)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '8 تنبيهات',
                              style: GoogleFonts.notoKufiArabic(
                                color: const Color(0xFFEF4444),
                                fontSize: 8.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(Icons.warning_rounded, color: Color(0xFFEF4444), size: 10),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],

                    // Student counts
                    Text(
                      '${exam.studentsCount} طالب',
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.people_alt_outlined, color: Color(0xFF94A3B8), size: 12),
                    const SizedBox(width: 12),

                    // Level
                    Text(
                      exam.gradeLevel,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.school_outlined, color: Color(0xFF94A3B8), size: 12),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Right: Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getIconBgColor(exam.iconCode, isActive),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIcon(exam.iconCode),
              color: _getIconColor(exam.iconCode, isActive),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String code) {
    switch (code) {
      case 'math':
        return Icons.calculate_outlined;
      case 'physics':
        return Icons.biotech_outlined; // microscope feel
      case 'biology':
        return Icons.opacity_rounded; // DNA/droplet feel
      case 'lang':
        return Icons.translate_rounded;
      case 'chemistry':
        return Icons.science_outlined;
      default:
        return Icons.edit_note_rounded;
    }
  }

  Color _getIconBgColor(String code, bool isActive) {
    if (!isActive) return const Color(0xFFF1F5F9); // grey ended bg
    switch (code) {
      case 'math':
      case 'chemistry':
        return const Color(0xFFEFF6FF); // blue
      case 'biology':
        return const Color(0xFFFFF1F2); // rose/pink
      case 'physics':
        return const Color(0xFFECFDF5); // emerald
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getIconColor(String code, bool isActive) {
    if (!isActive) return const Color(0xFF64748B); // grey ended icon
    switch (code) {
      case 'math':
      case 'chemistry':
        return const Color(0xFF005BBF);
      case 'biology':
        return const Color(0xFFF43F5E);
      case 'physics':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF64748B);
    }
  }
}
