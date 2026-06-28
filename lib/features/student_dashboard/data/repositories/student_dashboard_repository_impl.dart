import '../../domain/entities/exam_schedule_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/student_achievement_entity.dart';
import '../../domain/repositories/student_dashboard_repository.dart';
import '../datasources/student_dashboard_local_datasource.dart';

class StudentDashboardRepositoryImpl implements StudentDashboardRepository {
  final StudentDashboardLocalDataSource localDataSource;

  StudentDashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ExamScheduleEntity>> getStudentSchedule() async {
    return await localDataSource.getStudentSchedule();
  }

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    return await localDataSource.getNotifications();
  }

  @override
  Future<StudentAchievementEntity> getStudentAchievements() async {
    return await localDataSource.getStudentAchievements();
  }
}
