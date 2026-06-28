import '../../domain/entities/instructor_exam_entity.dart';
import '../../domain/entities/proctoring_alert_entity.dart';
import '../../domain/entities/instructor_stats_entity.dart';
import '../../domain/entities/instructor_report_data_entity.dart';

abstract class InstructorDashboardLocalDataSource {
  Future<List<InstructorExamEntity>> getInstructorExams();
  Future<List<ProctoringAlertEntity>> getProctoringAlerts();
  Future<InstructorStatsEntity> getInstructorStats();
  Future<InstructorReportDataEntity> getInstructorReportData();
}

class InstructorDashboardLocalDataSourceImpl implements InstructorDashboardLocalDataSource {
  @override
  Future<List<InstructorExamEntity>> getInstructorExams() async {
    return const [
      InstructorExamEntity(
        id: 'ie1',
        title: 'الرياضيات المتقدمة - نهائي',
        subtitle: 'المستوى 12 • اختبار التفاضل والتكامل',
        studentsCount: 142,
        gradeLevel: 'المستوى 12',
        status: 'active',
        remainingTimeOrDuration: '45:20',
        iconCode: 'math',
        totalStudents: 30,
        completedStudents: 24, // 80% progress
      ),
      InstructorExamEntity(
        id: 'ie2',
        title: 'الفيزياء التطبيقية',
        subtitle: 'المستوى 11 • اختبار نهاية الفصل الأول',
        studentsCount: 89,
        gradeLevel: 'المستوى 11',
        status: 'ended',
        remainingTimeOrDuration: '01:12:05',
        iconCode: 'physics',
        totalStudents: 40,
        completedStudents: 40,
      ),
      InstructorExamEntity(
        id: 'ie3',
        title: 'الأحياء - الخلية',
        subtitle: 'المستوى 10 • اختبار البناء الخلوي والأنشطة',
        studentsCount: 218,
        gradeLevel: 'المستوى 10',
        status: 'active',
        remainingTimeOrDuration: '12:15',
        iconCode: 'biology',
        totalStudents: 50,
        completedStudents: 15,
      ),
      InstructorExamEntity(
        id: 'ie4',
        title: 'الأدب العربي الحديث',
        subtitle: 'المستوى 10 • الشعر والثر في العصر الحديث',
        studentsCount: 56,
        gradeLevel: 'المستوى 10',
        status: 'ended',
        remainingTimeOrDuration: '58:00',
        iconCode: 'lang',
        totalStudents: 25,
        completedStudents: 25,
      ),
      InstructorExamEntity(
        id: 'ie5',
        title: 'الكيمياء العضوية',
        subtitle: 'المستوى 12 • الهيدروكربونات وتفاعلاتها',
        studentsCount: 112,
        gradeLevel: 'المستوى 12',
        status: 'active',
        remainingTimeOrDuration: '32:45',
        iconCode: 'chemistry',
        totalStudents: 30,
        completedStudents: 18,
      ),
      
      // Progress list ONLY
      InstructorExamEntity(
        id: 'ie_prog1',
        title: 'اختبار النحو العربي - الصف العاشر',
        subtitle: 'قواعد النحو والإعراب المبسطة',
        studentsCount: 30,
        gradeLevel: 'الصف العاشر',
        status: 'active',
        remainingTimeOrDuration: '30:00',
        iconCode: 'lang',
        totalStudents: 30,
        completedStudents: 24, // 80%
      ),
      InstructorExamEntity(
        id: 'ie_prog2',
        title: 'الأدب الجاهلي - الصف الثاني عشر',
        subtitle: 'المعلقات وشعراء العصر الجاهلي',
        studentsCount: 28,
        gradeLevel: 'الصف الثاني عشر',
        status: 'active',
        remainingTimeOrDuration: '26:00',
        iconCode: 'lang',
        totalStudents: 28,
        completedStudents: 12, // 42%
      ),
    ];
  }

  @override
  Future<List<ProctoringAlertEntity>> getProctoringAlerts() async {
    return const [
      ProctoringAlertEntity(
        id: 'pa1',
        studentName: 'أحمد محمد',
        examTitle: 'اختبار الأحياء',
        alertMessage: 'تم الكشف عن وجود هاتف محمول في نطاق الكاميرا.',
        timeAgo: 'منذ ثانية',
        isReviewed: false,
        alertType: 'phone',
      ),
      ProctoringAlertEntity(
        id: 'pa2',
        studentName: 'سارة العلي',
        examTitle: 'الكيمياء العضوية',
        alertMessage: 'تم رصد مغادرة المتصفح (tab-switching).',
        timeAgo: 'منذ 5 دقائق',
        isReviewed: true,
        alertType: 'tab_switch',
      ),
    ];
  }

  @override
  Future<InstructorStatsEntity> getInstructorStats() async {
    return const InstructorStatsEntity(
      activeExamsCount: 5,
      todayExamsCount: 2,
      totalStudentsCount: 142,
      averageGradePercentage: 84.0,
      averageGradeChangePercentage: 4.0,
      pendingReportsCount: 12,
      rating: 4.9,
    );
  }

  @override
  Future<InstructorReportDataEntity> getInstructorReportData() async {
    return const InstructorReportDataEntity(
      gradeDistribution: [8.0, 15.0, 42.0, 25.0, 10.0], // mapping to [ضعيف, مقبول, جيد, جيد جدا, ممتاز]
      monthlyPerformance: [62.0, 70.0, 78.0, 84.0], // coordinates (Sept, Oct, Nov, Dec)
      topStudents: [
        ReportStudentEntity(
          name: 'عمر العتيبي',
          gradeLevel: 'المستوى العاشر - أ',
          scorePercentage: 98.5,
          detailText: '98.5% • المستوى العاشر - أ',
          status: 'normal',
        ),
        ReportStudentEntity(
          name: 'سارة القحطاني',
          gradeLevel: 'المستوى العاشر - ب',
          scorePercentage: 97.2,
          detailText: '97.2% • المستوى العاشر - ب',
          status: 'normal',
        ),
      ],
      attentionStudents: [
        ReportStudentEntity(
          name: 'خالد الشمري',
          gradeLevel: 'المستوى العاشر - أ',
          scorePercentage: 64.0,
          detailText: '64.0% • تراجع في آخر اختبارين',
          status: 'warning',
        ),
        ReportStudentEntity(
          name: 'ريما السديري',
          gradeLevel: 'المستوى العاشر - ب',
          scorePercentage: 58.5,
          detailText: '58.5% • لم تكمل المهمة الأخيرة',
          status: 'warning',
        ),
      ],
    );
  }
}
