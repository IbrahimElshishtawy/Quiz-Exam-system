import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/proctoring_alert_entity.dart';
import '../controllers/instructor_dashboard_controller.dart';

class ProctoringAlertCard extends GetView<InstructorDashboardController> {
  final ProctoringAlertEntity alert;

  const ProctoringAlertCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final bool isUnreviewed = !alert.isReviewed;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnreviewed ? const Color(0xFFFEE2E2) : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Review action button
          isUnreviewed
              ? ElevatedButton(
                  onPressed: () => controller.reviewProctoringAlert(alert.id),
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
                    'مراجعة',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : OutlinedButton(
                  onPressed: null, // Disabled / already checked
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  child: Text(
                    'تم الفحص',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 10,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ),
          const SizedBox(width: 12),

          // Center: Message details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Header (Student Name & Subject)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Time Ago
                    Text(
                      alert.timeAgo,
                      style: GoogleFonts.notoKufiArabic(
                        color: isUnreviewed ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
                        fontSize: 10,
                        fontWeight: isUnreviewed ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Student name & subject title
                    Expanded(
                      child: Text(
                        '${alert.studentName} - ${alert.examTitle}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.notoKufiArabic(
                          color: textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Alert details content
                Text(
                  alert.alertMessage,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    color: isUnreviewed ? const Color(0xFFB91C1C) : const Color(0xFF64748B),
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Right: Avatar icon
          CircleAvatar(
            radius: 20,
            backgroundColor: isUnreviewed ? const Color(0xFFFEE2E2) : const Color(0xFFF1F5F9),
            child: Icon(
              alert.alertType == 'phone' ? Icons.phone_android_rounded : Icons.tab_unselected_rounded,
              color: isUnreviewed ? const Color(0xFFEF4444) : const Color(0xFF64748B),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
