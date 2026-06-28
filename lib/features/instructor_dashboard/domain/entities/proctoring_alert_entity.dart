class ProctoringAlertEntity {
  final String id;
  final String studentName;
  final String examTitle;
  final String alertMessage;
  final String timeAgo;
  final bool isReviewed;
  final String alertType; // 'phone', 'tab_switch'

  const ProctoringAlertEntity({
    required this.id,
    required this.studentName,
    required this.examTitle,
    required this.alertMessage,
    required this.timeAgo,
    required this.isReviewed,
    required this.alertType,
  });
}
