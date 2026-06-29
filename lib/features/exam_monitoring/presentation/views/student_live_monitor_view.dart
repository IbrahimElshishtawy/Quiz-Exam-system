import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_monitoring_controller.dart';
import '../../domain/entities/student_monitor.dart';
import '../../domain/entities/violation_log.dart';
import 'student_chat_view.dart';

class StudentLiveMonitorView extends GetView<ExamMonitoringController> {
  const StudentLiveMonitorView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: textDark),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'إدارة الاختبارات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final StudentMonitor? s = controller.selectedStudent.value;
          if (s == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Simulated Live Video Feed with Face Tracking Frame
                Container(
                  height: 220,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Background gradient
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.face_retouching_natural_rounded,
                              size: 110,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),

                        // Blinking/Active Face-tracking bounding box overlay
                        Center(
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent, width: 2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                // Corner marks or label
                                Positioned(
                                  top: -1,
                                  left: 6,
                                  child: Container(
                                    color: Colors.blueAccent,
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    child: const Text(
                                      'ID: تتبع الوجه نشط',
                                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Blinking red Live tag
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '1080p',
                                  style: GoogleFonts.ibmPlexSans(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'مباشر',
                                  style: GoogleFonts.notoKufiArabic(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 6),
                                _BlinkingRedDot(),
                              ],
                            ),
                          ),
                        ),

                        // Bottom status overlay text
                        Positioned(
                          bottom: 12,
                          right: 16,
                          child: Text(
                            'تتبع الوجه: نشط',
                            style: GoogleFonts.notoKufiArabic(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Indicators Grid (4 items)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.85,
                    children: [
                      _buildIndicatorCard('السؤال الحالي', '${s.currentQuestion} / ${s.totalQuestions}', Icons.list_alt_rounded),
                      _buildIndicatorCard('الوقت المتبقي', s.timeRemaining, Icons.timer_outlined, isAlert: true),
                      _buildIndicatorCard('حالة الجهاز', '${s.deviceBattery}%', Icons.battery_charging_full_rounded, isBattery: true),
                      _buildIndicatorCard('الاتصال', s.connectionStatus, Icons.wifi_rounded, isWifi: true),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 3. Student Profile Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        child: Text(
                          s.name.substring(0, 1),
                          style: GoogleFonts.notoKufiArabic(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Details (RTL order)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              s.name,
                              style: GoogleFonts.notoKufiArabic(fontSize: 14, fontWeight: FontWeight.bold, color: textDark),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'رقم القيد: ${s.id}',
                              style: GoogleFonts.ibmPlexSans(fontSize: 12, color: const Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'الصف الثاني عشر - علمي',
                              style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Violations Log Timeline
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, bottom: 80),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${s.violationsCount} تنبيهات',
                              style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFFEF4444), fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'سجل المخالفات',
                            style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 16),

                      // Timeline list
                      s.violationLogs.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                child: Text(
                                  'لا توجد مخالفات مسجلة لهذا الطالب',
                                  style: GoogleFonts.notoKufiArabic(fontSize: 12, color: const Color(0xFF64748B)),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: s.violationLogs.length,
                              itemBuilder: (context, idx) {
                                final log = s.violationLogs[idx];
                                return _buildTimelineItem(log, idx == s.violationLogs.length - 1);
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
        onPressed: () {
          Get.to(() => const StudentChatView());
        },
      ),
    );
  }

  Widget _buildIndicatorCard(String title, String val, IconData icon, {bool isAlert = false, bool isBattery = false, bool isWifi = false}) {
    const textDark = Color(0xFF1E293B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: isAlert
                    ? const Color(0xFFEF4444)
                    : isBattery
                        ? const Color(0xFF10B981)
                        : isWifi
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF64748B),
                size: 20,
              ),
              Text(
                title,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 10,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            val,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isAlert ? const Color(0xFFEF4444) : textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(ViolationLog log, bool isLast) {
    const textDark = Color(0xFF1E293B);
    final indicatorColor = log.type == 'start' ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    log.time,
                    style: GoogleFonts.ibmPlexSans(fontSize: 10, color: const Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    log.title,
                    style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold, color: textDark),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    log.description,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoKufiArabic(fontSize: 10.5, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Circle indicator & Line
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BlinkingRedDot extends StatefulWidget {
  @override
  State<_BlinkingRedDot> createState() => _BlinkingRedDotState();
}

class _BlinkingRedDotState extends State<_BlinkingRedDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void onInit() {}

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFFEF4444),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
