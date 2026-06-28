import '../../domain/entities/exam_schedule_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/student_achievement_entity.dart';

abstract class StudentDashboardLocalDataSource {
  Future<List<ExamScheduleEntity>> getStudentSchedule();
  Future<List<NotificationEntity>> getNotifications();
  Future<StudentAchievementEntity> getStudentAchievements();
}

class StudentDashboardLocalDataSourceImpl implements StudentDashboardLocalDataSource {
  @override
  Future<List<ExamScheduleEntity>> getStudentSchedule() async {
    // Current date to base the schedule on (e.g. Sept 11, 2024 as per screenshots)
    final now = DateTime.now();
    
    return [
      // September 11 Exams
      ExamScheduleEntity(
        id: '1',
        title: 'العلوم والأحياء - الوحدة الثالثة',
        subtitle: 'أساسيات الكيمياء الحيوية وعلم الخلية',
        dateTime: DateTime(now.year, now.month, 11),
        timeString: '09:00 ص - 10:30 ص',
        durationMinutes: 90,
        questionsCount: 30,
        location: 'القاعة 4',
        status: 'confirmed', // مؤكد
        category: 'academic',
        iconCode: 'flask',
      ),
      ExamScheduleEntity(
        id: '2',
        title: 'الرياضيات المتقدمة',
        subtitle: 'اختبار التفاضل والتكامل',
        dateTime: DateTime(now.year, now.month, 11),
        timeString: '01:00 م - 02:30 م',
        durationMinutes: 90,
        questionsCount: 25,
        location: 'عبر الإنترنت',
        status: 'preparatory', // تحضيري
        category: 'academic',
        iconCode: 'calculator',
      ),
      
      // Other days (represented by calendar dots in screenshots: 4, 8, 14, 19, 22)
      ExamScheduleEntity(
        id: '3',
        title: 'الفيزياء: الميكانيكا',
        subtitle: 'الميكانيكا الكلاسيكية والحركة الدائرية',
        dateTime: DateTime(now.year, now.month, 4),
        timeString: '03:00 م - 04:00 م',
        durationMinutes: 60,
        questionsCount: 47,
        location: 'القاعة 1',
        status: 'soon', // يبدأ قريباً
        category: 'academic',
        iconCode: 'math',
      ),
      ExamScheduleEntity(
        id: '4',
        title: 'أساسيات علم الوراثة',
        subtitle: 'مبادئ علم الأحياء الجزيئي والجينات',
        dateTime: DateTime(now.year, now.month, 8),
        timeString: '01:30 م - 02:30 م',
        durationMinutes: 60,
        questionsCount: 20,
        location: 'عبر الإنترنت',
        status: 'confirmed',
        category: 'academic',
        iconCode: 'flask',
      ),
      ExamScheduleEntity(
        id: '5',
        title: 'النحو والصرف - مستوى 2',
        subtitle: 'قواعد اللغة العربية وآدابها',
        dateTime: DateTime(now.year, now.month, 14),
        timeString: '10:00 ص - 10:45 ص',
        durationMinutes: 45,
        questionsCount: 15,
        location: 'القاعة 3',
        status: 'confirmed',
        category: 'mock', // تجريبي
        iconCode: 'lang',
      ),
      ExamScheduleEntity(
        id: '6',
        title: 'تطوير واجهات المستخدم',
        subtitle: 'علوم الحاسوب وتطبيقات الويب الحديثة',
        dateTime: DateTime(now.year, now.month, 22),
        timeString: '01:00 م - 03:00 م',
        durationMinutes: 120,
        questionsCount: 40,
        location: 'عبر الإنترنت',
        status: 'confirmed',
        category: 'academic',
        iconCode: 'code',
      ),
    ];
  }

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    return const [
      NotificationEntity(
        id: 'n1',
        title: 'تم إضافة امتحان الفيزياء المتقدمة',
        content: 'يتوفر الآن اختبار تجريبي جديد لوحدة "الميكانيكا الكلاسيكية". نوصي بالبدء قبل الموعد النهائي.',
        type: 'new_exam',
        timeAgo: 'الآن',
        isRead: false,
        badgeText: null,
      ),
      NotificationEntity(
        id: 'n2',
        title: 'تقييم الذكاء الاصطناعي الأسبوعي',
        content: 'التقييم الدوري لمستوى التقدم متاح الآن في لوحة التحكم الخاصة بك.',
        type: 'ai_assessment',
        timeAgo: 'منذ ساعتين',
        isRead: false,
        badgeText: null,
      ),
      NotificationEntity(
        id: 'n3',
        title: 'صدرت نتيجة اختبار الكيمياء الحيوية',
        content: 'تهانينا! لقد حصلت على 94%، مما يضعك في أعلى 5% من دفعتك.',
        type: 'result',
        timeAgo: 'جديد',
        isRead: false,
        badgeText: 'أداء متميز: +12% عن المرة السابقة',
      ),
      NotificationEntity(
        id: 'n4',
        title: 'تحديث النظام',
        content: 'أضفنا ميزات AI جديدة للمساعدة في حل المسائل المعقدة.',
        type: 'update',
        timeAgo: 'منذ يوم واحد',
        isRead: true,
        badgeText: null,
      ),
      NotificationEntity(
        id: 'n5',
        title: 'تذكير بالجدول',
        content: 'يبدأ فصل المراجعة المباشر غداً في الساعة 10 صباحاً.',
        type: 'reminder',
        timeAgo: 'منذ يوم واحد',
        isRead: true,
        badgeText: null,
      ),
    ];
  }

  @override
  Future<StudentAchievementEntity> getStudentAchievements() async {
    return const StudentAchievementEntity(
      totalExams: 24,
      averageScore: 92.0,
      experiencePoints: 4850,
      nextLevelProgressPercentage: 0.85, // 85%
    );
  }
}
