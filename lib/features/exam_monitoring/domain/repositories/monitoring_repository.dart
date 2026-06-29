import '../entities/student_monitor.dart';

abstract class MonitoringRepository {
  Stream<List<StudentMonitor>> getMonitoringStudents();
  Future<StudentMonitor> getStudentDetails(String id);
  Future<void> sendWarning(String studentId, String message);
  Future<void> broadcastWarning(String message);
  Future<void> togglePauseExam();
}
