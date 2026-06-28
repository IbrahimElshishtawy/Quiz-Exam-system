import '../entities/instructor_exam_entity.dart';
import '../entities/proctoring_alert_entity.dart';
import '../entities/instructor_stats_entity.dart';
import '../entities/instructor_report_data_entity.dart';

abstract class InstructorDashboardRepository {
  Future<List<InstructorExamEntity>> getInstructorExams();
  Future<List<ProctoringAlertEntity>> getProctoringAlerts();
  Future<InstructorStatsEntity> getInstructorStats();
  Future<InstructorReportDataEntity> getInstructorReportData();
}
