import '../../domain/entities/instructor_exam_entity.dart';
import '../../domain/entities/proctoring_alert_entity.dart';
import '../../domain/entities/instructor_stats_entity.dart';
import '../../domain/entities/instructor_report_data_entity.dart';
import '../../domain/repositories/instructor_dashboard_repository.dart';
import '../datasources/instructor_dashboard_local_datasource.dart';

class InstructorDashboardRepositoryImpl implements InstructorDashboardRepository {
  final InstructorDashboardLocalDataSource localDataSource;

  InstructorDashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<List<InstructorExamEntity>> getInstructorExams() async {
    return await localDataSource.getInstructorExams();
  }

  @override
  Future<List<ProctoringAlertEntity>> getProctoringAlerts() async {
    return await localDataSource.getProctoringAlerts();
  }

  @override
  Future<InstructorStatsEntity> getInstructorStats() async {
    return await localDataSource.getInstructorStats();
  }

  @override
  Future<InstructorReportDataEntity> getInstructorReportData() async {
    return await localDataSource.getInstructorReportData();
  }
}
