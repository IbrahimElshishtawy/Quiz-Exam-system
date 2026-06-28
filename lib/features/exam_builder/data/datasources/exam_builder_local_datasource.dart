import '../../domain/entities/exam_draft_entity.dart';
import '../../domain/entities/builder_activity_entity.dart';

abstract class ExamBuilderLocalDataSource {
  Future<List<ExamDraftEntity>> getExams();
  Future<List<BuilderActivityEntity>> getBuilderActivities();
  Future<void> saveExam(ExamDraftEntity exam);
  Future<void> deleteExam(String id);
}

class ExamBuilderLocalDataSourceImpl implements ExamBuilderLocalDataSource {
  // In-memory list initialized with the exact mock data from Screenshot 1
  final List<ExamDraftEntity> _cachedExams = [
    ExamDraftEntity(
      id: 'ex1',
      title: 'اختبار منتصف الفصل - الفيزياء',
      description: 'الوحدة الثالثة: الديناميكا والميكانيكا',
      status: 'active',
      studentsCount: 145,
      remainingTimeOrDuration: '45:20',
      averageGrade: '',
      lastModifiedText: '',
      subject: 'الفيزياء',
      classLevel: 'الصف الثالث الثانوي',
      coverPath: '',
      dateText: '15 أكتوبر 2023',
      durationMinutes: 45,
      shuffleQuestions: true,
      shuffleOptions: true,
      questionsCountMCQ: 15,
      questionsCountEssay: 5,
      totalGrade: 100,
      isLockdown: true,
      proctoringLevel: 'High',
    ),
    ExamDraftEntity(
      id: 'ex2',
      title: 'اختبار الكيمياء الشهري',
      description: 'العناصر الانتقالية والتفاعلات',
      status: 'draft',
      studentsCount: 0,
      remainingTimeOrDuration: '',
      averageGrade: '',
      lastModifiedText: 'منذ ساعتين',
      subject: 'الكيمياء',
      classLevel: 'الصف الأول الثانوي',
      coverPath: '',
      dateText: '18 أكتوبر 2023',
      durationMinutes: 60,
      shuffleQuestions: true,
      shuffleOptions: true,
      questionsCountMCQ: 10,
      questionsCountEssay: 2,
      totalGrade: 50,
      isLockdown: false,
      proctoringLevel: 'Medium',
    ),
    ExamDraftEntity(
      id: 'ex3',
      title: 'الرياضيات - الجبر والهندسة',
      description: 'اختبار نهاية الوحدة الثانية',
      status: 'completed',
      studentsCount: 120,
      remainingTimeOrDuration: '01:00:00',
      averageGrade: '88/100',
      lastModifiedText: '',
      subject: 'الرياضيات',
      classLevel: 'الصف الثاني الثانوي',
      coverPath: '',
      dateText: '10 أكتوبر 2023',
      durationMinutes: 60,
      shuffleQuestions: true,
      shuffleOptions: true,
      questionsCountMCQ: 20,
      questionsCountEssay: 4,
      totalGrade: 100,
      isLockdown: true,
      proctoringLevel: 'High',
    ),
  ];

  final List<BuilderActivityEntity> _cachedActivities = [
    BuilderActivityEntity(
      id: 'act1',
      message: 'بلاغ عن غش - قاعة 4',
      timeAgo: 'منذ 5 دقائق',
      iconType: 'flag',
    ),
    BuilderActivityEntity(
      id: 'act2',
      message: 'اكتمل تصحيح 20 ورقة',
      timeAgo: 'منذ 15 دقيقة',
      iconType: 'check',
    ),
    BuilderActivityEntity(
      id: 'act3',
      message: 'انضم طالب جديد للفيزياء',
      timeAgo: 'منذ ساعة',
      iconType: 'person',
    ),
  ];

  @override
  Future<List<ExamDraftEntity>> getExams() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_cachedExams);
  }

  @override
  Future<List<BuilderActivityEntity>> getBuilderActivities() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_cachedActivities);
  }

  @override
  Future<void> saveExam(ExamDraftEntity exam) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final idx = _cachedExams.indexWhere((e) => e.id == exam.id);
    if (idx != -1) {
      _cachedExams[idx] = exam;
    } else {
      _cachedExams.add(exam);
    }
  }

  @override
  Future<void> deleteExam(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cachedExams.removeWhere((e) => e.id == id);
  }
}
