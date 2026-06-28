import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/student_dashboard_controller.dart';
import '../widgets/notification_card_widget.dart';
import '../../domain/entities/notification_entity.dart';

class StudentNotificationsTab extends GetView<StudentDashboardController> {
  const StudentNotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => controller.markAllNotificationsAsRead(),
          child: Text(
            'تحديد الكل كمقروء',
            style: GoogleFonts.notoKufiArabic(
              color: primaryColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'الإشعارات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_rounded, color: primaryColor),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Pills Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Obx(() {
                final String activeFilter = controller.notificationFilter.value;

                return Row(
                  children: [
                    _buildFilterPill('unread', 'غير مقروءة', activeFilter == 'unread'),
                    const SizedBox(width: 10),
                    _buildFilterPill('new', 'جديد', activeFilter == 'new'),
                    const SizedBox(width: 10),
                    _buildFilterPill('all', 'الكل', activeFilter == 'all'),
                  ],
                );
              }),
            ),

            // Notifications List
            Expanded(
              child: Obx(() {
                final List<NotificationEntity> list = controller.getFilteredNotifications();

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.notifications_none_rounded, color: Color(0xFF94A3B8), size: 56),
                        const SizedBox(height: 12),
                        Text(
                          'لا توجد إشعارات حالياً.',
                          style: GoogleFonts.notoKufiArabic(color: const Color(0xFF64748B), fontSize: 13),
                        ),
                      ],
                    ),
                  );
                }

                // Group notifications by category
                final Map<String, List<NotificationEntity>> grouped = {};
                for (var n in list) {
                  String category = 'عام';
                  if (n.type == 'new_exam' || n.type == 'reminder') {
                    category = 'امتحانات جديدة';
                  } else if (n.type == 'result') {
                    category = 'النتائج والتقارير';
                  } else if (n.type == 'ai_assessment') {
                    category = 'تقييم الذكاء الاصطناعي الأسبوعي';
                  }
                  grouped.putIfAbsent(category, () => []).add(n);
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  children: grouped.keys.map((catName) {
                    final catList = grouped[catName]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Group Header Text
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0, bottom: 12.0),
                          child: Text(
                            catName,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: textDark.withOpacity(0.85),
                            ),
                          ),
                        ),
                        
                        // Notifications cards inside category
                        ...catList.map((n) => NotificationCardWidget(notification: n)),
                      ],
                    );
                  }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPill(String filterValue, String text, bool isActive) {
    const primaryColor = Color(0xFF005BBF);
    
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.notificationFilter.value = filterValue,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 38,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.notoKufiArabic(
              color: isActive ? Colors.white : const Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
