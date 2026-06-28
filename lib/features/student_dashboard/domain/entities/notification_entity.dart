class NotificationEntity {
  final String id;
  final String title;
  final String content;
  final String type; // 'new_exam', 'ai_assessment', 'result', 'update', 'reminder'
  final String timeAgo;
  final bool isRead;
  final String? badgeText;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.timeAgo,
    required this.isRead,
    this.badgeText,
  });
}
