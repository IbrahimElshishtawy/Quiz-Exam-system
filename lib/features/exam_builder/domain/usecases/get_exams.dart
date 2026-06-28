import '../entities/exam_draft_entity.dart';
import '../repositories/exam_builder_repository.dart';

class GetExamsUseCase {
  final ExamBuilderRepository repository;

  GetExamsUseCase(this.repository);

  Future<List<ExamDraftEntity>> call() async {
    return await repository.getExams();
  }
}
