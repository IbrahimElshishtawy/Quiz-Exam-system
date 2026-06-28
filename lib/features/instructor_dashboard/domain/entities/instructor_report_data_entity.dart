class ReportStudentEntity {
  final String name;
  final String gradeLevel;
  final double scorePercentage;
  final String detailText;
  final String? avatarUrl;
  final String status; // 'normal', 'warning'

  const ReportStudentEntity({
    required this.name,
    required this.gradeLevel,
    required this.scorePercentage,
    required this.detailText,
    this.avatarUrl,
    required this.status,
  });
}

class InstructorReportDataEntity {
  final List<double> gradeDistribution; // e.g. [10, 20, 45, 15, 10] mapping to [ضعيف, مقبول, جيد, جيد جدا, ممتاز]
  final List<double> monthlyPerformance; // monthly coordinates
  final List<ReportStudentEntity> topStudents;
  final List<ReportStudentEntity> attentionStudents;

  const InstructorReportDataEntity({
    required this.gradeDistribution,
    required this.monthlyPerformance,
    required this.topStudents,
    required this.attentionStudents,
  });
}
