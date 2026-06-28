import '../entities/exam_draft_entity.dart';
import '../entities/builder_activity_entity.dart';

abstract class ExamBuilderRepository {
  Future<List<ExamDraftEntity>> getExams();
  Future<List<BuilderActivityEntity>> getBuilderActivities();
  Future<void> saveExam(ExamDraftEntity exam);
  Future<void> deleteExam(String id);
}
