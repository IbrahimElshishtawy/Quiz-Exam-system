import '../entities/exam_schedule_entity.dart';
import '../repositories/student_dashboard_repository.dart';

class GetStudentSchedule {
  final StudentDashboardRepository repository;

  GetStudentSchedule(this.repository);

  Future<List<ExamScheduleEntity>> call() async {
    return await repository.getStudentSchedule();
  }
}
