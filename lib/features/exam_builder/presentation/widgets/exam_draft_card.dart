import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/exam_draft_entity.dart';
import '../controllers/exam_builder_controller.dart';

class ExamDraftCard extends GetView<ExamBuilderController> {
  final ExamDraftEntity exam;

  const ExamDraftCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);

    Color badgeBgColor = const Color(0xFFECFDF5);
    Color badgeTextColor = const Color(0xFF10B981);
    String statusLabel = 'نشط الآن';

    if (exam.status == 'draft') {
      badgeBgColor = const Color(0xFFF1F5F9);
      badgeTextColor = const Color(0xFF475569);
      statusLabel = 'مسودة';
    } else if (exam.status == 'completed') {
      badgeBgColor = const Color(0xFFEFF6FF);
      badgeTextColor = const Color(0xFF005BBF);
      statusLabel = 'مكتمل';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Row: Status badge and 3-dots option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
                onPressed: () {
                  if (exam.status == 'draft') {
                    _showOptionsSheet(context);
                  } else {
                    Get.snackbar('متابعة', 'هذه القائمة متوفرة للاختبارات المسودة حالياً.');
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusLabel,
                  style: GoogleFonts.notoKufiArabic(
                    color: badgeTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Exam Title
          Text(
            exam.title,
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle description
          Text(
            exam.description,
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),

          // Status Specific Details Row (RTL)
          _buildStatusDetails(),
          const SizedBox(height: 14),

          const Divider(color: Color(0xFFF1F5F9), height: 1),
          const SizedBox(height: 12),

          // Bottom Action Row
          _buildActionRow(),
        ],
      ),
    );
  }

  Widget _buildStatusDetails() {
    if (exam.status == 'active') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${exam.studentsCount} طالب متبقي',
                style: GoogleFonts.notoKufiArabic(color: const Color(0xFF64748B), fontSize: 11),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.people_alt_outlined, size: 16, color: Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${exam.remainingTimeOrDuration} متبقي',
                style: GoogleFonts.ibmPlexSans(color: const Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF94A3B8)),
            ],
          ),
        ],
      );
    } else if (exam.status == 'draft') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'آخر تعديل: ${exam.lastModifiedText}',
            style: GoogleFonts.notoKufiArabic(color: const Color(0xFF64748B), fontSize: 11),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF94A3B8)),
        ],
      );
    } else {
      // completed
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'متوسط الدرجات: ${exam.averageGrade}',
            style: GoogleFonts.ibmPlexSans(color: const Color(0xFF10B981), fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.analytics_outlined, size: 16, color: Color(0xFF10B981)),
        ],
      );
    }
  }

  Widget _buildActionRow() {
    const primaryColor = Color(0xFF005BBF);

    if (exam.status == 'active') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left action (Monitor icon button)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.visibility_outlined, color: Color(0xFF64748B), size: 18),
          ),
          // Right text button
          Text(
            'متابعة الأداء',
            style: GoogleFonts.notoKufiArabic(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else if (exam.status == 'draft') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left delete button
          IconButton(
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFFFF1F2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 18),
            onPressed: () => controller.deleteExamDraft(exam.id),
          ),
          // Right complete builder action
          InkWell(
            onTap: () {
              controller.currentTabIndex.value = 1; // Go to Create tab
              controller.wizardStep.value = 1; // Direct to Settings
              controller.titleCtrl.text = exam.title;
              controller.descCtrl.text = exam.description;
            },
            child: Text(
              'إكمال الإعداد',
              style: GoogleFonts.notoKufiArabic(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      // completed
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left download button
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.download_rounded, color: primaryColor, size: 18),
          ),
          // Right text action
          Text(
            'عرض النتائج',
            style: GoogleFonts.notoKufiArabic(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'خيارات مسودة الاختبار',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoKufiArabic(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 20),
              ListTile(
                trailing: const Icon(Icons.edit_outlined),
                title: Text('تعديل مسودة الاختبار', textAlign: TextAlign.right, style: GoogleFonts.notoKufiArabic(fontSize: 12)),
                onTap: () {
                  Navigator.pop(context);
                  controller.currentTabIndex.value = 1;
                  controller.titleCtrl.text = exam.title;
                  controller.descCtrl.text = exam.description;
                },
              ),
              const Divider(height: 1),
              ListTile(
                trailing: const Icon(Icons.delete_outline, color: Colors.redAccent),
                title: Text('حذف مسودة الاختبار', textAlign: TextAlign.right, style: GoogleFonts.notoKufiArabic(fontSize: 12, color: Colors.redAccent)),
                onTap: () {
                  Navigator.pop(context);
                  controller.deleteExamDraft(exam.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
