import '../entities/proctoring_alert_entity.dart';
import '../repositories/instructor_dashboard_repository.dart';

class GetProctoringAlerts {
  final InstructorDashboardRepository repository;

  GetProctoringAlerts(this.repository);

  Future<List<ProctoringAlertEntity>> call() async {
    return await repository.getProctoringAlerts();
  }
}
