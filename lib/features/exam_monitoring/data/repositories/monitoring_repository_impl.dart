import '../../domain/repositories/monitoring_repository.dart';
import '../../domain/entities/student_monitor.dart';
import '../datasources/mock_monitoring_datasource.dart';

class MonitoringRepositoryImpl implements MonitoringRepository {
  final MockMonitoringDatasource _datasource;

  MonitoringRepositoryImpl(this._datasource);

  @override
  Stream<List<StudentMonitor>> getMonitoringStudents() {
    return _datasource.getMonitoringStudents();
  }

  @override
  Future<StudentMonitor> getStudentDetails(String id) {
    return _datasource.getStudentDetails(id);
  }

  @override
  Future<void> sendWarning(String studentId, String message) async {
    await _datasource.sendWarning(studentId, message);
  }

  @override
  Future<void> broadcastWarning(String message) async {
    await _datasource.broadcastWarning(message);
  }

  @override
  Future<void> togglePauseExam() async {
    await _datasource.togglePauseExam();
  }
}
