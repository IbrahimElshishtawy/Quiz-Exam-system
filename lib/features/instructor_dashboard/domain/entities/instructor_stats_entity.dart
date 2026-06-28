class InstructorStatsEntity {
  final int activeExamsCount;
  final int todayExamsCount;
  final int totalStudentsCount;
  final double averageGradePercentage;
  final double averageGradeChangePercentage;
  final int pendingReportsCount;
  final double rating;

  const InstructorStatsEntity({
    required this.activeExamsCount,
    required this.todayExamsCount,
    required this.totalStudentsCount,
    required this.averageGradePercentage,
    required this.averageGradeChangePercentage,
    required this.pendingReportsCount,
    required this.rating,
  });
}
