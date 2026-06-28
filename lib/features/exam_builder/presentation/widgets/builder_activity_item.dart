import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/builder_activity_entity.dart';

class BuilderActivityItem extends StatelessWidget {
  final BuilderActivityEntity activity;

  const BuilderActivityItem({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _getBgColor(activity.iconType),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Left: Time Ago
          Text(
            activity.timeAgo,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 10,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 14),

          // Center: Message
          Expanded(
            child: Text(
              activity.message,
              textAlign: TextAlign.right,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Right: Icon Badge
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getBadgeColor(activity.iconType),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIcon(activity.iconType),
              color: _getIconColor(activity.iconType),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'flag':
        return Icons.flag_rounded;
      case 'check':
        return Icons.check_rounded;
      case 'person':
        return Icons.person_add_rounded;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'flag':
        return const Color(0xFFEF4444);
      case 'check':
        return const Color(0xFF10B981);
      case 'person':
        return const Color(0xFF005BBF);
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _getBadgeColor(String type) {
    switch (type) {
      case 'flag':
        return const Color(0xFFFEE2E2);
      case 'check':
        return const Color(0xFFD1FAE5);
      case 'person':
        return const Color(0xFFEFF6FF);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getBgColor(String type) {
    switch (type) {
      case 'flag':
        return const Color(0xFFFFF5F5);
      default:
        return const Color(0xFFF8FAFC);
    }
  }
}
