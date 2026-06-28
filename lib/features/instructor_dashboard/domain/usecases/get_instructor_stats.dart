import '../entities/instructor_stats_entity.dart';
import '../repositories/instructor_dashboard_repository.dart';

class GetInstructorStats {
  final InstructorDashboardRepository repository;

  GetInstructorStats(this.repository);

  Future<InstructorStatsEntity> call() async {
    return await repository.getInstructorStats();
  }
}
