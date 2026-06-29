import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/instructor_exam_entity.dart';

import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class OngoingExamProgressCard extends StatelessWidget {
  final InstructorExamEntity exam;

  const OngoingExamProgressCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final double percentage = exam.totalStudents > 0
        ? exam.completedStudents / exam.totalStudents
        : 0.0;

    return InkWell(
      onTap: () => Get.toNamed(Routes.EXAM_MONITOR),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Percentage text
              Text(
                '${(percentage * 100).toInt()}%',
                style: GoogleFonts.ibmPlexSans(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Title
              Expanded(
                child: Text(
                  exam.title,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Subtitle (Student count progress)
          Text(
            'أنهى منه ${exam.completedStudents} من ${exam.totalStudents} طالب',
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),

          // Custom Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 8,
              width: double.infinity,
              color: const Color(0xFFE2E8F0),
              child: FractionallySizedBox(
                alignment: Alignment.centerRight, // RTL alignment
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
