import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/instructor_exam_entity.dart';
import '../../domain/entities/proctoring_alert_entity.dart';
import '../../domain/entities/instructor_stats_entity.dart';
import '../../domain/entities/instructor_report_data_entity.dart';
import '../../domain/usecases/get_instructor_exams.dart';
import '../../domain/usecases/get_instructor_report_data.dart';
import '../../domain/usecases/get_instructor_stats.dart';
import '../../domain/usecases/get_proctoring_alerts.dart';

class InstructorChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  InstructorChatMessage({required this.text, required this.isUser, required this.time});
}

class InstructorDashboardController extends GetxController {
  final GetInstructorExams getInstructorExamsUseCase;
  final GetProctoringAlerts getProctoringAlertsUseCase;
  final GetInstructorStats getInstructorStatsUseCase;
  final GetInstructorReportData getInstructorReportDataUseCase;

  InstructorDashboardController({
    required this.getInstructorExamsUseCase,
    required this.getProctoringAlertsUseCase,
    required this.getInstructorStatsUseCase,
    required this.getInstructorReportDataUseCase,
  });

  // State variables
  final RxInt currentTabIndex = 0.obs;
  final RxBool isLoading = false.obs;

  // Lists
  final RxList<InstructorExamEntity> exams = <InstructorExamEntity>[].obs;
  final RxList<ProctoringAlertEntity> alerts = <ProctoringAlertEntity>[].obs;
  final Rxn<InstructorStatsEntity> stats = Rxn<InstructorStatsEntity>();
  final Rxn<InstructorReportDataEntity> reportData = Rxn<InstructorReportDataEntity>();

  // Dropdown states for reports
  final RxString selectedSubject = 'الذكاء الاصطناعي'.obs;
  final RxString selectedClass = 'المستوى العاشر - أ'.obs;
  final RxString selectedPeriod = 'آخر 30 يوم'.obs;

  // Preferences (Settings)
  final RxBool examNotificationsEnabled = true.obs;
  final RxBool darkModeEnabled = false.obs;

  // AI Assistant Chat Messages
  final RxList<InstructorChatMessage> chatMessages = <InstructorChatMessage>[].obs;
  final RxBool isAiTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    _initializeChat();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      final List<InstructorExamEntity> exList = await getInstructorExamsUseCase();
      exams.assignAll(exList);

      final List<ProctoringAlertEntity> alList = await getProctoringAlertsUseCase();
      alerts.assignAll(alList);

      final InstructorStatsEntity st = await getInstructorStatsUseCase();
      stats.value = st;

      final InstructorReportDataEntity rep = await getInstructorReportDataUseCase();
      reportData.value = rep;
    } catch (e) {
      Get.snackbar('خطأ', 'فشل تحميل بيانات لوحة التحكم: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Reports Update Action
  Future<void> updateReportsData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      // Trigger a light reload
      await fetchDashboardData();
      Get.snackbar(
        'تم التحديث',
        'تم تحديث إحصائيات تقارير المادة بنجاح.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('خطأ', 'فشل التحديث');
    } finally {
      isLoading.value = false;
    }
  }

  // Proctoring Alert Review action
  void reviewProctoringAlert(String id) {
    final int index = alerts.indexWhere((a) => a.id == id);
    if (index != -1) {
      final alert = alerts[index];
      alerts[index] = ProctoringAlertEntity(
        id: alert.id,
        studentName: alert.studentName,
        examTitle: alert.examTitle,
        alertMessage: alert.alertMessage,
        timeAgo: alert.timeAgo,
        isReviewed: true,
        alertType: alert.alertType,
      );
      
      Get.snackbar(
        'تم الفحص',
        'تم تسجيل فحص المخالفة بنجاح للطالب ${alert.studentName}.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF005BBF),
        colorText: Colors.white,
      );
    }
  }

  // Student Actions
  void sendReminder(String studentName) {
    Get.snackbar(
      'تذكير فوري',
      'تم إرسال تنبيه تذكيري للطالبة $studentName لإكمال مهامها.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF005BBF),
      colorText: Colors.white,
    );
  }

  void scheduleSupport(String studentName) {
    Get.snackbar(
      'جدولة جلسة دعم',
      'تم جدولة جلسة دعم دراسي إضافية للطالب $studentName وسيتلقى إشعاراً بالموعد.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF005BBF),
      colorText: Colors.white,
    );
  }

  // AI Chat Assistant
  void _initializeChat() {
    chatMessages.assignAll([
      InstructorChatMessage(
        text: 'مرحباً أستاذة سارة! أنا مساعد المعلم الذكي. يمكنني مساعدتك في صياغة أسئلة اختبار، تقييم الواجبات، أو مراجعة إحصائيات تقارير الفصول. كيف أخدمك اليوم؟ 🏫',
        isUser: false,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ]);
  }

  Future<void> sendChatMessage(String text) async {
    if (text.trim().isEmpty) return;

    chatMessages.add(InstructorChatMessage(
      text: text,
      isUser: true,
      time: DateTime.now(),
    ));

    isAiTyping.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      String aiResponse = 'بناءً على التقارير الحالية: يواجه 40% من طلاب المستوى العاشر صعوبة في مادة "الذكاء الاصطناعي". هل ترغب في أن أقوم بإنشاء ورقة مراجعة تفاعلية لهم؟';

      final String lowerText = text.toLowerCase();
      if (lowerText.contains('اختبار') || lowerText.contains('امتحان')) {
        aiResponse = 'بالتأكيد! يمكنني صياغة 10 أسئلة اختيار من متعدد في موضوع التفاضل والتكامل للمستوى 12. هل تريد تحديد مستوى الصعوبة؟';
      } else if (lowerText.contains('تقرير') || lowerText.contains('أداء')) {
        aiResponse = 'وفقاً لإحصائيات الفصل (أ/1): متوسط الدرجات هو 84% مع أداء متقدم ومتميز للطلاب عمر وسارة. سأقوم بتلخيص التقرير في ملف PDF لو أردت.';
      } else if (lowerText.contains('مراقبة') || lowerText.contains('غش')) {
        aiResponse = 'رصد نظام المراقبة الذكي محاولة تبديل نوافذ للطالبة سارة علي، وتم الكشف عن هاتف محمول للطالب أحمد محمد. أنصح بفتح شاشة المراقبة لمراجعة الصور وفحص التسجيلات.';
      }

      chatMessages.add(InstructorChatMessage(
        text: aiResponse,
        isUser: false,
        time: DateTime.now(),
      ));
    } catch (e) {
      // ignore
    } finally {
      isAiTyping.value = false;
    }
  }
}
