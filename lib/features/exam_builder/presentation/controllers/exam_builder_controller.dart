import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/exam_draft_entity.dart';
import '../../domain/entities/builder_activity_entity.dart';
import '../../domain/usecases/get_exams.dart';
import '../../domain/usecases/get_builder_activities.dart';
import '../../domain/usecases/save_exam.dart';
import '../../domain/usecases/delete_exam.dart';

class ExamBuilderController extends GetxController {
  final GetExamsUseCase getExamsUseCase;
  final GetBuilderActivitiesUseCase getBuilderActivitiesUseCase;
  final SaveExamUseCase saveExamUseCase;
  final DeleteExamUseCase deleteExamUseCase;

  ExamBuilderController({
    required this.getExamsUseCase,
    required this.getBuilderActivitiesUseCase,
    required this.saveExamUseCase,
    required this.deleteExamUseCase,
  });

  // Bottom Navigation state
  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = false.obs;

  // Data lists
  final RxList<ExamDraftEntity> exams = <ExamDraftEntity>[].obs;
  final RxList<BuilderActivityEntity> activities = <BuilderActivityEntity>[].obs;

  // Filter & Search states
  final RxString activeFilter = 'الكل'.obs;
  final RxString searchQuery = ''.obs;

  // Stepper/Wizard Step index (0: Details, 1: Settings, 2: Review)
  final RxInt wizardStep = 0.obs;

  // Wizard fields & controllers
  final detailsFormKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final RxString selectedSubject = 'الفيزياء المتقدمة'.obs;
  final RxString selectedGradeLevel = 'الصف الثالث الثانوي'.obs;
  final RxString coverImage = ''.obs; // cover path simulation

  // Wizard Settings Step
  final RxInt durationMinutes = 60.obs;
  final RxBool hasPassword = false.obs;
  final RxString allowedAttempts = 'محاولة واحدة فقط'.obs;
  final Rx<DateTime> startDate = DateTime(2024, 5, 20).obs;
  final Rx<DateTime> endDate = DateTime(2024, 5, 22).obs;
  final Rx<TimeOfDay> openTime = const TimeOfDay(hour: 8, minute: 0).obs;
  final Rx<TimeOfDay> closeTime = const TimeOfDay(hour: 14, minute: 0).obs;
  final RxBool isPublic = true.obs;
  final RxBool shuffleQuestions = true.obs;
  final RxBool shuffleOptions = true.obs;

  // Wizard Questions Structure (Simulation)
  final RxInt mcqCount = 15.obs;
  final RxInt essayCount = 5.obs;
  final RxInt totalGrade = 100.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExamsAndActivities();
  }

  Future<void> fetchExamsAndActivities() async {
    isLoading.value = true;
    try {
      final listEx = await getExamsUseCase();
      exams.assignAll(listEx);

      final listAct = await getBuilderActivitiesUseCase();
      activities.assignAll(listAct);
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في تحميل البيانات: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void nextStep() {
    if (wizardStep.value == 0) {
      final isValid = detailsFormKey.currentState?.validate() ?? false;
      if (!isValid) return;
    }
    if (wizardStep.value < 2) {
      wizardStep.value++;
    }
  }

  void prevStep() {
    if (wizardStep.value > 0) {
      wizardStep.value--;
    }
  }

  Future<void> saveCurrentExamWizard() async {
    isLoading.value = true;
    try {
      final newExam = ExamDraftEntity(
        id: 'ex_${DateTime.now().millisecondsSinceEpoch}',
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
        status: 'draft', // Saved as Draft initially
        studentsCount: 0,
        remainingTimeOrDuration: '',
        averageGrade: '',
        lastModifiedText: 'الآن',
        subject: selectedSubject.value,
        classLevel: selectedGradeLevel.value,
        coverPath: coverImage.value,
        dateText: '${startDate.value.day} مايو ${startDate.value.year}',
        durationMinutes: durationMinutes.value,
        shuffleQuestions: shuffleQuestions.value,
        shuffleOptions: shuffleOptions.value,
        questionsCountMCQ: mcqCount.value,
        questionsCountEssay: essayCount.value,
        totalGrade: totalGrade.value,
        isLockdown: true,
        proctoringLevel: 'High',
      );

      await saveExamUseCase(newExam);
      await fetchExamsAndActivities();

      Get.snackbar(
        'تم بنجاح',
        'تم حفظ ونشر الاختبار بنجاح.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );

      resetWizard();
      currentTabIndex.value = 0; // Go back to Home
    } catch (e) {
      Get.snackbar('خطأ', 'فشل حفظ الاختبار: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExamDraft(String id) async {
    try {
      await deleteExamUseCase(id);
      await fetchExamsAndActivities();
      Get.snackbar(
        'تم الحذف',
        'تم حذف مسودة الاختبار بنجاح.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('خطأ', 'فشل الحذف');
    }
  }

  void resetWizard() {
    titleCtrl.clear();
    descCtrl.clear();
    coverImage.value = '';
    wizardStep.value = 0;
  }

  // Filter helper
  List<ExamDraftEntity> get filteredExams {
    final query = searchQuery.value.trim().toLowerCase();
    final filter = activeFilter.value;

    return exams.where((exam) {
      final matchesQuery = query.isEmpty ||
          exam.title.toLowerCase().contains(query) ||
          exam.subject.toLowerCase().contains(query);

      if (!matchesQuery) return false;

      if (filter == 'الكل') return true;
      if (filter == 'نشط') return exam.status == 'active';
      if (filter == 'مسودة') return exam.status == 'draft';
      if (filter == 'مؤرشف') return exam.status == 'completed'; // completed maps to archived/ended

      return true;
    }).toList();
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }
}
