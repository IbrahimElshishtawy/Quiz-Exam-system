class ExamDraftEntity {
  final String id;
  final String title;
  final String description;
  final String status; // 'active', 'draft', 'completed'
  final int studentsCount;
  final String remainingTimeOrDuration;
  final String averageGrade;
  final String lastModifiedText;
  final String subject;
  final String classLevel;
  final String coverPath;
  final String dateText;
  final int durationMinutes;
  final bool shuffleQuestions;
  final bool shuffleOptions;
  final int questionsCountMCQ;
  final int questionsCountEssay;
  final int totalGrade;
  final bool isLockdown;
  final String proctoringLevel; // 'High', 'Medium', 'Low'

  ExamDraftEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.studentsCount,
    required this.remainingTimeOrDuration,
    required this.averageGrade,
    required this.lastModifiedText,
    required this.subject,
    required this.classLevel,
    required this.coverPath,
    required this.dateText,
    required this.durationMinutes,
    required this.shuffleQuestions,
    required this.shuffleOptions,
    required this.questionsCountMCQ,
    required this.questionsCountEssay,
    required this.totalGrade,
    required this.isLockdown,
    required this.proctoringLevel,
  });
}
