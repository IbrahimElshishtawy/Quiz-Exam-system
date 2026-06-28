import '../entities/exam_schedule_entity.dart';
import '../entities/notification_entity.dart';
import '../entities/student_achievement_entity.dart';

abstract class StudentDashboardRepository {
  Future<List<ExamScheduleEntity>> getStudentSchedule();
  Future<List<NotificationEntity>> getNotifications();
  Future<StudentAchievementEntity> getStudentAchievements();
}
