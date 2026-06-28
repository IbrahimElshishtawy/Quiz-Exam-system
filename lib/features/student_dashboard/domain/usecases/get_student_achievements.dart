import '../entities/student_achievement_entity.dart';
import '../repositories/student_dashboard_repository.dart';

class GetStudentAchievements {
  final StudentDashboardRepository repository;

  GetStudentAchievements(this.repository);

  Future<StudentAchievementEntity> call() async {
    return await repository.getStudentAchievements();
  }
}
