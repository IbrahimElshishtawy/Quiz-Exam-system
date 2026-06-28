import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/notification_entity.dart';
import '../controllers/student_dashboard_controller.dart';

class NotificationCardWidget extends GetView<StudentDashboardController> {
  final NotificationEntity notification;

  const NotificationCardWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    final bool isUnread = !notification.isRead;
    final Color sideBarColor = _getSideColor(notification.type, isUnread);

    return GestureDetector(
      onTap: () => controller.markNotificationAsRead(notification.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnread ? primaryColor.withOpacity(0.15) : const Color(0xFFE2E8F0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isUnread ? 0.03 : 0.01),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Left Vertical Indicator Line
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 5,
                  color: sideBarColor,
                ),
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Right Content: Text Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Title & Time Ago
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Time
                              Text(
                                notification.timeAgo,
                                style: GoogleFonts.notoKufiArabic(
                                  color: isUnread ? primaryColor : const Color(0xFF94A3B8),
                                  fontSize: 10,
                                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              // Title
                              Text(
                                notification.title,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.notoKufiArabic(
                                  color: textDark,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Description Content
                          Text(
                            notification.content,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.notoKufiArabic(
                              color: const Color(0xFF64748B),
                              fontSize: 11,
                              height: 1.6,
                            ),
                          ),

                          // Badge specific to Result (Green Pill)
                          if (notification.type == 'result' && notification.badgeText != null) ...[
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5), // soft green
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.trending_up, color: Color(0xFF047857), size: 12),
                                  const SizedBox(width: 4),
                                  Text(
                                    notification.badgeText!,
                                    style: GoogleFonts.notoKufiArabic(
                                      color: const Color(0xFF065F46),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          // Action Buttons specific to New Exam
                          if (notification.type == 'new_exam') ...[
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Details Button
                                OutlinedButton(
                                  onPressed: () => Get.toNamed(Routes.EXAM_DETAILS),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: primaryColor, width: 1.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  child: Text(
                                    'التفاصيل',
                                    style: GoogleFonts.notoKufiArabic(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                
                                // Start Now Button
                                ElevatedButton(
                                  onPressed: () => Get.toNamed(Routes.EXAM_PLAYER),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  child: Text(
                                    'ابدأ الآن',
                                    style: GoogleFonts.notoKufiArabic(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Left Content: Icon avatar
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _getIconBgColor(notification.type),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getIcon(notification.type),
                        color: _getIconColor(notification.type),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSideColor(String type, bool isUnread) {
    if (!isUnread) return Colors.transparent;
    switch (type) {
      case 'new_exam':
      case 'update':
        return const Color(0xFF005BBF);
      case 'result':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF94A3B8);
    }
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'new_exam':
        return Icons.edit_note_rounded;
      case 'ai_assessment':
        return Icons.psychology_rounded;
      case 'result':
        return Icons.emoji_events_rounded;
      case 'update':
        return Icons.campaign_rounded;
      case 'reminder':
        return Icons.access_time_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _getIconBgColor(String type) {
    switch (type) {
      case 'new_exam':
      case 'update':
        return const Color(0xFFEFF6FF);
      case 'result':
        return const Color(0xFFD1FAE5);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'new_exam':
      case 'update':
        return const Color(0xFF005BBF);
      case 'result':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF64748B);
    }
  }
}
