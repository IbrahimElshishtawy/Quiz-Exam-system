import '../repositories/exam_builder_repository.dart';

class DeleteExamUseCase {
  final ExamBuilderRepository repository;

  DeleteExamUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deleteExam(id);
  }
}
