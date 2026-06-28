import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/instructor_report_data_entity.dart';
import '../controllers/instructor_dashboard_controller.dart';

class StudentReportCardWidget extends GetView<InstructorDashboardController> {
  final ReportStudentEntity student;

  const StudentReportCardWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final bool isWarning = student.status == 'warning';
    final bool isReminder = student.name == 'ريما السديري';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isWarning ? const Color(0xFFF8FAFC) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Left: Action button (if warning)
          if (isWarning)
            SizedBox(
              height: 32,
              child: isReminder
                  ? ElevatedButton(
                      onPressed: () => controller.sendReminder(student.name),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      child: Text(
                        'تذكير',
                        style: GoogleFonts.notoKufiArabic(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () => controller.scheduleSupport(student.name),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005BBF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      child: Text(
                        'جدولة دعم',
                        style: GoogleFonts.notoKufiArabic(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            )
          else
            const SizedBox.shrink(),

          // Center: Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Name
                Text(
                  student.name,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 3),

                // Subtitle specs
                Text(
                  student.detailText,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 9.5,
                    color: isWarning ? const Color(0xFFEF4444) : const Color(0xFF64748B),
                    fontWeight: isWarning ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Right: Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE2E8F0),
            child: const Icon(Icons.person, color: Color(0xFF64748B), size: 20),
          ),
        ],
      ),
    );
  }
}
