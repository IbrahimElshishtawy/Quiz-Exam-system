import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_monitoring_controller.dart';
import '../../widgets/circular_integrity_chart.dart';
import '../../widgets/progress_bar_chart.dart';
import '../student_live_monitor_view.dart';

class MonitorDashboardTab extends GetView<ExamMonitoringController> {
  const MonitorDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Live status banner card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: const Border(
                right: BorderSide(color: primaryColor, width: 4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Attendance
                Column(
                  children: [
                    Text(
                      'الحاضرون',
                      style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '124/150',
                      style: GoogleFonts.ibmPlexSans(fontSize: 14, fontWeight: FontWeight.bold, color: textDark),
                    ),
                  ],
                ),
                
                // Divider
                Container(width: 1, height: 35, color: const Color(0xFFE2E8F0)),

                // Remaining Time
                Column(
                  children: [
                    Text(
                      'الوقت المتبقي',
                      style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '45:20',
                      style: GoogleFonts.ibmPlexSans(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFEF4444)),
                    ),
                  ],
                ),

                // Divider
                Container(width: 1, height: 35, color: const Color(0xFFE2E8F0)),

                // Banner Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'البث المباشر: اختبار العلوم النهائي',
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. Student progress card
          _buildCardWrapper(
            title: 'تقدم الطلاب',
            icon: Icons.trending_up_rounded,
            child: const ProgressBarChart(
              startingRatio: 0.15,
              midwayRatio: 0.55,
              finishedRatio: 0.30,
              startingCount: 20,
              midwayCount: 74,
              finishedCount: 30,
            ),
          ),
          const SizedBox(height: 16),

          // 3. Integrity Index
          _buildCardWrapper(
            title: 'مؤشر النزاهة',
            icon: Icons.shield_outlined,
            child: Column(
              children: [
                const SizedBox(height: 12),
                const CircularIntegrityChart(percentage: 0.92),
                const SizedBox(height: 16),
                Text(
                  'معدل الالتزام بالقواعد ضمن النطاق الآمن',
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 4. Violation Types Card
          _buildCardWrapper(
            title: 'أنواع التجاوزات',
            icon: Icons.warning_amber_rounded,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  _buildViolationStatRow('تبديل النوافذ (Tab)', 0.65, const Color(0xFFEF4444)),
                  const SizedBox(height: 12),
                  _buildViolationStatRow('عدم التعرف على الوجه', 0.25, const Color(0xFF3B82F6)),
                  const SizedBox(height: 12),
                  _buildViolationStatRow('كشف ضجيج', 0.10, const Color(0xFF64748B)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 5. Last Violations List
          _buildCardWrapper(
            title: 'آخر التجاوزات المرصودة',
            icon: Icons.history_toggle_off_rounded,
            actionLabel: 'مشاهدة الكل',
            onActionTap: () => controller.currentTabIndex.value = 1,
            child: Obx(() {
              final list = controller.allStudents.where((s) => s.violationsCount > 0).take(4).toList();

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                separatorBuilder: (context, idx) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
                itemBuilder: (context, idx) {
                  final s = list[idx];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      height: 38,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEE2E2),
                          foregroundColor: const Color(0xFFEF4444),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => controller.sendWarning(s.id, 'يرجى الالتزام التام بقوانين الاختبار لتجنب الإلغاء.'),
                        child: Text(
                          'تحذير',
                          style: GoogleFonts.notoKufiArabic(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              s.name,
                              style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold, color: textDark),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'رقم الطالب: ${s.id}',
                              style: GoogleFonts.ibmPlexSans(fontSize: 10, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          icon: const Icon(Icons.videocam_outlined, color: Color(0xFF64748B)),
                          onPressed: () {
                            controller.selectStudent(s);
                            Get.to(() => const StudentLiveMonitorView());
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 16),

          // 6. Attendance Summary
          _buildCardWrapper(
            title: 'ملخص الحضور',
            icon: Icons.checklist_rounded,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(color: Color(0xFF64748B), shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 4),
                          Text('غائب', style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(width: 12),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 4),
                          Text('حضر', style: GoogleFonts.notoKufiArabic(fontSize: 11, color: primaryColor)),
                        ],
                      ),
                      Text(
                        'اكتمال الحضور: 83%',
                        style: GoogleFonts.notoKufiArabic(fontSize: 11, fontWeight: FontWeight.bold, color: textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.83,
                      minHeight: 8,
                      color: primaryColor,
                      backgroundColor: const Color(0xFFE2E8F0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '124 طالب',
                      style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF64748B)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Bottom alert buttons
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {
              final controllerText = TextEditingController();
              Get.defaultDialog(
                title: 'بث تنبيه جماعي',
                titleStyle: GoogleFonts.notoKufiArabic(fontSize: 14, fontWeight: FontWeight.bold),
                content: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: controllerText,
                    decoration: InputDecoration(
                      hintText: 'اكتب نص التنبيه الجماعي هنا...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    maxLines: 3,
                  ),
                ),
                textConfirm: 'بث الآن',
                textCancel: 'إلغاء',
                confirmTextColor: Colors.white,
                buttonColor: primaryColor,
                onConfirm: () {
                  controller.broadcastWarning(controllerText.text);
                  Get.back();
                },
              );
            },
            icon: const Icon(Icons.campaign_outlined, size: 22),
            label: Text(
              'بث تنبيه للجميع',
              style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          
          Obx(() => OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: controller.isExamPaused.value ? Colors.white : const Color(0xFF64748B),
              backgroundColor: controller.isExamPaused.value ? const Color(0xFF64748B) : Colors.transparent,
              side: BorderSide(color: controller.isExamPaused.value ? Colors.transparent : const Color(0xFFCBD5E1), width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => controller.togglePauseExam(),
            icon: Icon(controller.isExamPaused.value ? Icons.play_arrow_rounded : Icons.pause_rounded, size: 22),
            label: Text(
              controller.isExamPaused.value ? 'استئناف الاختبار' : 'إيقاف الاختبار مؤقتاً',
              style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          )),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCardWrapper({
    required String title,
    required IconData icon,
    required Widget child,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    const textDark = Color(0xFF1E293B);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header of card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (actionLabel != null && onActionTap != null)
                  TextButton(
                    onPressed: onActionTap,
                    child: Text(
                      actionLabel,
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF005BBF),
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(icon, color: const Color(0xFF64748B), size: 20),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          child,
        ],
      ),
    );
  }

  Widget _buildViolationStatRow(String label, double ratio, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(ratio * 100).toInt()}%',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 11.5,
                color: const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 6,
            color: color,
            backgroundColor: const Color(0xFFF1F5F9),
          ),
        ),
      ],
    );
  }
}
