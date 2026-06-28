import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/exam_schedule_entity.dart';

class UpcomingExamCardWidget extends StatelessWidget {
  final ExamScheduleEntity exam;

  const UpcomingExamCardWidget({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    final bool isSoon = exam.status == 'soon' || exam.id == '2'; // mathematically soon

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSoon ? primaryColor.withOpacity(0.2) : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSoon ? 0.04 : 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top specs (Starts soon / category badge)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: Category tag (Academic / Mock)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  exam.category == 'academic' ? 'أكاديمي' : 'تجريبي',
                  style: GoogleFonts.notoKufiArabic(
                    color: const Color(0xFF64748B),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Right: Starts soon badge
              if (isSoon)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'يبدأ قريباً',
                    style: GoogleFonts.notoKufiArabic(
                      color: const Color(0xFFEF4444),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Row: Details & Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      exam.title,
                      style: GoogleFonts.notoKufiArabic(
                        color: textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle
                    Text(
                      exam.subtitle,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Metadata info (Time and duration)
                    Row(
                      children: [
                        // Duration
                        Icon(Icons.timer_outlined, color: const Color(0xFF94A3B8), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${exam.durationMinutes} دقيقة',
                          style: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF64748B),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Time
                        Icon(Icons.calendar_today_rounded, color: const Color(0xFF94A3B8), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          exam.dateTime.day == DateTime.now().day
                              ? exam.timeString.split(' ')[0]
                              : '${exam.dateTime.day} سبتمبر',
                          style: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF64748B),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Right Icon Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getIconBgColor(exam.iconCode),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getIcon(exam.iconCode),
                  color: _getIconColor(exam.iconCode),
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bottom Action Button: View Details
          SizedBox(
            height: 48,
            width: double.infinity,
            child: isSoon
                ? ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.EXAM_DETAILS),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'عرض التفاصيل',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () => Get.toNamed(Routes.EXAM_DETAILS),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryColor, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'عرض التفاصيل',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 13,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String code) {
    switch (code) {
      case 'flask':
        return Icons.science_outlined;
      case 'calculator':
        return Icons.calculate_outlined;
      case 'math':
        return Icons.functions_rounded;
      case 'lang':
        return Icons.translate_rounded;
      case 'code':
        return Icons.code_rounded;
      default:
        return Icons.edit_note_rounded;
    }
  }

  Color _getIconBgColor(String code) {
    switch (code) {
      case 'flask':
        return const Color(0xFFD1FAE5); // green
      case 'calculator':
        return const Color(0xFFEFF6FF); // blue
      case 'lang':
        return const Color(0xFFF3E8FF); // purple
      case 'code':
        return const Color(0xFFFEF3C7); // amber
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getIconColor(String code) {
    switch (code) {
      case 'flask':
        return const Color(0xFF047857);
      case 'calculator':
        return const Color(0xFF005BBF);
      case 'lang':
        return const Color(0xFF7C3AED);
      case 'code':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF64748B);
    }
  }
}
