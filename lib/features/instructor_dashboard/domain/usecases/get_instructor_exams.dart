import '../entities/instructor_exam_entity.dart';
import '../repositories/instructor_dashboard_repository.dart';

class GetInstructorExams {
  final InstructorDashboardRepository repository;

  GetInstructorExams(this.repository);

  Future<List<InstructorExamEntity>> call() async {
    return await repository.getInstructorExams();
  }
}
