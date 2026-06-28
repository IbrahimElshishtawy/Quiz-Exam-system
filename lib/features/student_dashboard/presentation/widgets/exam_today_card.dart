import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/exam_schedule_entity.dart';

class ExamTodayCard extends StatelessWidget {
  final ExamScheduleEntity exam;

  const ExamTodayCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const cardBgColor = Color(0xFFF8FAFC);
    const textDark = Color(0xFF1E293B);

    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Status badge and Subject Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getIcon(exam.iconCode),
                      color: primaryColor,
                      size: 20,
                    ),
                  ),

                  // Remaining status badge (Green)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1FAE5), // Soft green
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'يبدأ بعد 15 دقيقة',
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF065F46),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Title
              Text(
                exam.title,
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle
              Text(
                exam.subtitle,
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),

          // Metadata row and button
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(color: Color(0xFFE2E8F0), height: 16),
              // Meta Specs Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMetaIconText(Icons.alarm_rounded, exam.timeString.split(' ')[0]),
                  _buildMetaIconText(Icons.help_outline_rounded, '${exam.questionsCount} سؤال'),
                  _buildMetaIconText(Icons.timer_outlined, '${exam.durationMinutes} د'),
                ],
              ),
              const SizedBox(height: 12),

              // Prepare button
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.EXAM_DETAILS),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A), // Dark slate
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'استعد',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.notoKufiArabic(
            color: const Color(0xFF64748B),
            fontSize: 9,
          ),
        ),
        const SizedBox(width: 3),
        Icon(icon, color: const Color(0xFF94A3B8), size: 12),
      ],
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
}
