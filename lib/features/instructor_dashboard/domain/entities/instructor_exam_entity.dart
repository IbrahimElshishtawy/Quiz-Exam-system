class InstructorExamEntity {
  final String id;
  final String title;
  final String subtitle;
  final int studentsCount;
  final String gradeLevel; // e.g. "المستوى 12", "الصف العاشر"
  final String status; // 'active', 'ended'
  final String remainingTimeOrDuration; // e.g. "45:20", "58:00"
  final String iconCode; // 'math', 'physics', 'biology', 'lang', 'chemistry'
  final int totalStudents; // for progress bar
  final int completedStudents; // for progress bar

  const InstructorExamEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.studentsCount,
    required this.gradeLevel,
    required this.status,
    required this.remainingTimeOrDuration,
    required this.iconCode,
    required this.totalStudents,
    required this.completedStudents,
  });
}
