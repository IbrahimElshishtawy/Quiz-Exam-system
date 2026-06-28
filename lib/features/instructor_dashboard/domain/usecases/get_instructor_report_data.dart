import '../entities/instructor_report_data_entity.dart';
import '../repositories/instructor_dashboard_repository.dart';

class GetInstructorReportData {
  final InstructorDashboardRepository repository;

  GetInstructorReportData(this.repository);

  Future<InstructorReportDataEntity> call() async {
    return await repository.getInstructorReportData();
  }
}
