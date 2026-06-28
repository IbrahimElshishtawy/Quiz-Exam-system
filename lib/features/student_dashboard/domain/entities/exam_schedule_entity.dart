class ExamScheduleEntity {
  final String id;
  final String title;
  final String subtitle;
  final DateTime dateTime;
  final String timeString;
  final int durationMinutes;
  final int questionsCount;
  final String location; // e.g. "القاعة 4", "عبر الإنترنت"
  final String status; // 'confirmed', 'preparatory', 'soon'
  final String category; // 'academic', 'mock'
  final String iconCode; // 'flask', 'calculator', 'math', 'lang', 'code'

  const ExamScheduleEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.timeString,
    required this.durationMinutes,
    required this.questionsCount,
    required this.location,
    required this.status,
    required this.category,
    required this.iconCode,
  });
}
