import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_monitoring_controller.dart';
import '../../../domain/entities/student_monitor.dart';
import '../student_live_monitor_view.dart';

class MonitorGridTab extends GetView<ExamMonitoringController> {
  const MonitorGridTab({super.key});

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.015),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              textAlign: TextAlign.right,
              onChanged: (val) => controller.setSearchQuery(val),
              decoration: InputDecoration(
                hintText: 'البحث عن طالب برقم القيد أو الاسم...',
                hintStyle: GoogleFonts.notoKufiArabic(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),

        // 2. Filter Chips Scrollable Row
        SizedBox(
          height: 48,
          child: Obx(() {
            final activeFilter = controller.activeFilter.value;
            final allCount = controller.allStudents.length;
            final activeCount = controller.allStudents.where((s) => s.liveStatus == 'active').length;
            final alertCount = controller.allStudents.where((s) => s.liveStatus == 'eye_tracking').length;
            final violationCount = controller.allStudents.where((s) => s.liveStatus == 'window_switch').length;
            final offlineCount = controller.allStudents.where((s) => s.liveStatus == 'offline').length;

            return ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              reverse: true, // RTL flow
              children: [
                _buildFilterChip('all', 'الكل ($allCount)', activeFilter == 'all'),
                _buildFilterChip('active', 'نشط ($activeCount)', activeFilter == 'active'),
                _buildFilterChip('alerts', 'تنبيهات ($alertCount)', activeFilter == 'alerts'),
                _buildFilterChip('violations', 'مخالفات ($violationCount)', activeFilter == 'violations'),
                _buildFilterChip('offline', 'أوفلاين ($offlineCount)', activeFilter == 'offline'),
              ],
            );
          }),
        ),
        const SizedBox(height: 8),

        // 3. Grid of student live feeds
        Expanded(
          child: Obx(() {
            final list = controller.filteredStudents;
            if (list.isEmpty) {
              return Center(
                child: Text(
                  'لا يوجد طلاب يطابقون الفلتر المختار',
                  style: GoogleFonts.notoKufiArabic(fontSize: 12, color: const Color(0xFF64748B)),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.76, // Height/Width aspect ratio
              ),
              itemCount: list.length,
              itemBuilder: (context, idx) {
                final s = list[idx];
                return _buildStudentFeedCard(context, s);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String filterKey, String label, bool isSelected) {
    const primaryColor = Color(0xFF005BBF);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: InkWell(
        onTap: () => controller.setFilter(filterKey),
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? primaryColor : const Color(0xFFE2E8F0),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentFeedCard(BuildContext context, StudentMonitor student) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final bool isOffline = student.liveStatus == 'offline';
    final double progressRatio = student.currentQuestion / student.totalQuestions;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: student.liveStatus == 'window_switch'
              ? const Color(0xFFEF4444)
              : student.liveStatus == 'eye_tracking'
                  ? const Color(0xFFF59E0B)
                  : const Color(0xFFE2E8F0),
          width: student.liveStatus == 'active' ? 1.0 : 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Simulated Live Video Feed Box
          Expanded(
            child: Stack(
              children: [
                // Simulated feed visual
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark studio canvas
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF1E293B),
                        isOffline ? const Color(0xFF0F172A) : const Color(0xFF334155),
                      ],
                    ),
                  ),
                  child: Center(
                    child: isOffline
                        ? const Icon(Icons.videocam_off_outlined, color: Color(0xFF64748B), size: 36)
                        : Icon(Icons.face_retouching_natural_rounded, color: Colors.white.withOpacity(0.18), size: 54),
                  ),
                ),

                // Status Badge Overlay
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: student.statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      student.statusLabel,
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Remaining time indicator overlay
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      student.timeRemaining,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Info Footer
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  student.name,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'قيد: ${student.id}',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 9.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),

                // Mini progress indicator
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressRatio,
                    minHeight: 4,
                    color: student.liveStatus == 'window_switch'
                        ? const Color(0xFFEF4444)
                        : primaryColor,
                    backgroundColor: const Color(0xFFF1F5F9),
                  ),
                ),
                const SizedBox(height: 8),

                // Action click Details button
                SizedBox(
                  height: 28,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      controller.selectStudent(student);
                      Get.to(() => const StudentLiveMonitorView());
                    },
                    child: Text(
                      student.liveStatus == 'window_switch' ? 'إرسال تحذير' : 'عرض التفاصيل',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: student.liveStatus == 'window_switch'
                            ? const Color(0xFFEF4444)
                            : primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
