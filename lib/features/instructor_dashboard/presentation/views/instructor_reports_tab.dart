import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/instructor_dashboard_controller.dart';
import '../widgets/report_bar_chart_widget.dart';
import '../widgets/report_line_chart_widget.dart';
import '../widgets/student_report_card_widget.dart';

class InstructorReportsTab extends GetView<InstructorDashboardController> {
  const InstructorReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final List<String> subjects = ['الذكاء الاصطناعي', 'الرياضيات المتقدمة', 'الفيزياء التطبيقية'];
    final List<String> classes = ['المستوى العاشر - أ', 'المستوى العاشر - ب', 'المستوى الحادي عشر'];
    final List<String> periods = ['آخر 30 يوم', 'آخر 6 أشهر', 'الفصل الدراسي الحالي'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.download_outlined, color: primaryColor),
          onPressed: () {
            Get.snackbar('تحميل التقرير', 'تم البدء في تصدير التقرير الفصلي كملف PDF.');
          },
        ),
        centerTitle: true,
        title: Text(
          'ملخص التقارير',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Dropdown Filter Panel Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Subject Dropdown
                    _buildDropdownLabel('المادة الدراسية'),
                    Obx(() => _buildDropdown(
                          subjects,
                          controller.selectedSubject.value,
                          (val) => controller.selectedSubject.value = val!,
                        )),
                    const SizedBox(height: 12),

                    // Class Dropdown
                    _buildDropdownLabel('الصف'),
                    Obx(() => _buildDropdown(
                          classes,
                          controller.selectedClass.value,
                          (val) => controller.selectedClass.value = val!,
                        )),
                    const SizedBox(height: 12),

                    // Period Dropdown
                    _buildDropdownLabel('الفترة الزمنية'),
                    Obx(() => _buildDropdown(
                          periods,
                          controller.selectedPeriod.value,
                          (val) => controller.selectedPeriod.value = val!,
                        )),
                    const SizedBox(height: 18),

                    // Sync update button: "تحديث البيانات"
                    Obx(() {
                      final bool loading = controller.isLoading.value;

                      return ElevatedButton.icon(
                        onPressed: loading ? null : () => controller.updateReportsData(),
                        icon: loading
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.tune, color: Colors.white, size: 16),
                        label: Text(
                          'تحديث البيانات',
                          style: GoogleFonts.notoKufiArabic(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Grade Distribution Chart (Bar)
              Obx(() {
                final rep = controller.reportData.value;
                if (rep == null) return const SizedBox.shrink();
                return ReportBarChartWidget(values: rep.gradeDistribution);
              }),
              const SizedBox(height: 24),

              // 3. Average Performance Chart (Line)
              Obx(() {
                final rep = controller.reportData.value;
                if (rep == null) return const SizedBox.shrink();
                return ReportLineChartWidget(values: rep.monthlyPerformance);
              }),
              const SizedBox(height: 28),

              // 4. "الطلاب المتفوقون" list section
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Group Header Badge
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFECFDF5), // light green
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'الطلاب المتفوقون',
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF047857),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.emoji_events, color: Color(0xFF10B981), size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Top Student items
                    Obx(() {
                      final rep = controller.reportData.value;
                      if (rep == null) return const SizedBox.shrink();

                      return Column(
                        children: rep.topStudents
                            .map((st) => StudentReportCardWidget(student: st))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5. "طلاب يحتاجون اهتماماً" list section
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Group Header Warning Badge
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF1F2), // light red
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'طلاب يحتاجون اهتماماً',
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFB91C1C),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.warning_rounded, color: Color(0xFFEF4444), size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Attention Student items
                    Obx(() {
                      final rep = controller.reportData.value;
                      if (rep == null) return const SizedBox.shrink();

                      return Column(
                        children: rep.attentionStudents
                            .map((st) => StudentReportCardWidget(student: st))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(
          fontSize: 11,
          color: const Color(0xFF64748B),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String value, ValueChanged<String?> onChanged) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          icon: const Icon(Icons.expand_more_rounded, color: Color(0xFF64748B)),
          alignment: Alignment.centerRight,
          items: items
              .map((it) => DropdownMenuItem<String>(
                    value: it,
                    child: Text(
                      it,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.notoKufiArabic(fontSize: 12),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
