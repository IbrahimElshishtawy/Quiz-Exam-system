import '../entities/exam_draft_entity.dart';
import '../repositories/exam_builder_repository.dart';

class SaveExamUseCase {
  final ExamBuilderRepository repository;

  SaveExamUseCase(this.repository);

  Future<void> call(ExamDraftEntity exam) async {
    await repository.saveExam(exam);
  }
}
