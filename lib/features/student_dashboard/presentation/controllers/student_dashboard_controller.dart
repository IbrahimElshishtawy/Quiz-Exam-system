import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/exam_schedule_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/student_achievement_entity.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/get_student_achievements.dart';
import '../../domain/usecases/get_student_schedule.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessage({required this.text, required this.isUser, required this.time});
}

class StudentDashboardController extends GetxController {
  final GetStudentSchedule getStudentScheduleUseCase;
  final GetNotifications getNotificationsUseCase;
  final GetStudentAchievements getStudentAchievementsUseCase;

  StudentDashboardController({
    required this.getStudentScheduleUseCase,
    required this.getNotificationsUseCase,
    required this.getStudentAchievementsUseCase,
  });

  // Navigation and Selection state
  final RxInt currentTabIndex = 0.obs;
  
  // Set default calendar date to Sep 11, 2024 to match the screenshot tasks automatically
  final Rx<DateTime> selectedDate = DateTime(2024, 9, 11).obs;

  // Loaded data
  final RxList<ExamScheduleEntity> schedules = <ExamScheduleEntity>[].obs;
  final RxList<NotificationEntity> notifications = <NotificationEntity>[].obs;
  final Rxn<StudentAchievementEntity> achievements = Rxn<StudentAchievementEntity>();

  // Filtering states
  final RxString notificationFilter = 'all'.obs; // 'all', 'new', 'unread'
  final RxString upcomingExamsFilter = 'all'.obs; // 'all', 'academic', 'mock'

  // Loading and Sync states
  final RxBool isLoading = false.obs;
  final RxBool isSyncing = false.obs;
  final RxString lastSyncTime = 'منذ ساعتين'.obs;

  // Join session card inputs
  final TextEditingController sessionCodeController = TextEditingController();
  final RxString sessionCode = ''.obs;

  // AI Assistant Chat Messages
  final RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  final RxBool isAiTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    sessionCodeController.addListener(() {
      sessionCode.value = sessionCodeController.text;
    });
    fetchDashboardData();
    _initializeChat();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      final List<ExamScheduleEntity> schedList = await getStudentScheduleUseCase();
      schedules.assignAll(schedList);

      final List<NotificationEntity> notifList = await getNotificationsUseCase();
      notifications.assignAll(notifList);

      final StudentAchievementEntity ach = await getStudentAchievementsUseCase();
      achievements.value = ach;
    } catch (e) {
      Get.snackbar('Error', 'فشل تحميل بيانات لوحة التحكم: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Google Calendar Sync Simulation
  Future<void> syncGoogleCalendar() async {
    isSyncing.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1800));
      lastSyncTime.value = 'الآن';
      Get.snackbar(
        'مزامنة ناجحة',
        'تم مزامنة مواعيد اختباراتك مع Google Calendar بنجاح.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('خطأ', 'فشلت المزامنة');
    } finally {
      isSyncing.value = false;
    }
  }

  // Join Session Code Simulation
  Future<void> joinExamSession() async {
    final String code = sessionCode.value.trim();
    if (code.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال رمز الجلسة');
      return;
    }
    if (code.length < 5) {
      Get.snackbar('خطأ', 'رمز الجلسة غير صالح');
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      // Route directly to exam details
      Get.toNamed(Routes.EXAM_DETAILS);
      sessionCodeController.clear();
    } catch (e) {
      Get.snackbar('خطأ', 'فشل الانضمام للجلسة');
    } finally {
      isLoading.value = false;
    }
  }

  // Calendar logic helpers
  List<ExamScheduleEntity> getFilteredSchedulesForDate(DateTime date) {
    return schedules.where((s) => s.dateTime.day == date.day && s.dateTime.month == date.month && s.dateTime.year == date.year).toList();
  }

  bool dateHasTasks(DateTime date) {
    return schedules.any((s) => s.dateTime.day == date.day && s.dateTime.month == date.month && s.dateTime.year == date.year);
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Notification actions
  void markNotificationAsRead(String id) {
    final int index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final notif = notifications[index];
      notifications[index] = NotificationEntity(
        id: notif.id,
        title: notif.title,
        content: notif.content,
        type: notif.type,
        timeAgo: notif.timeAgo,
        isRead: true,
        badgeText: notif.badgeText,
      );
    }
  }

  void markAllNotificationsAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      if (!notifications[i].isRead) {
        final notif = notifications[i];
        notifications[i] = NotificationEntity(
          id: notif.id,
          title: notif.title,
          content: notif.content,
          type: notif.type,
          timeAgo: notif.timeAgo,
          isRead: true,
          badgeText: notif.badgeText,
        );
      }
    }
    Get.snackbar(
      'تحديث',
      'تم تحديد جميع الإشعارات كمقروءة.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF005BBF),
      colorText: Colors.white,
    );
  }

  List<NotificationEntity> getFilteredNotifications() {
    final filter = notificationFilter.value;
    if (filter == 'unread') {
      return notifications.where((n) => !n.isRead).toList();
    } else if (filter == 'new') {
      return notifications.where((n) => n.timeAgo == 'الآن' || n.timeAgo == 'جديد').toList();
    }
    return notifications;
  }

  // Upcoming Exams List Filtering
  List<ExamScheduleEntity> getFilteredUpcomingExams() {
    final filter = upcomingExamsFilter.value;
    // Get all future/scheduled exams (including today's other tasks) sorted by date
    final list = schedules.toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    if (filter == 'academic') {
      return list.where((e) => e.category == 'academic').toList();
    } else if (filter == 'mock') {
      return list.where((e) => e.category == 'mock').toList();
    }
    return list;
  }

  // AI Chat Assistant
  void _initializeChat() {
    chatMessages.assignAll([
      ChatMessage(
        text: 'مرحباً بك! أنا مساعد الذكاء الاصطناعي الخاص بك. كيف يمكنني مساعدتك في استعدادات اختباراتك اليوم؟ 🎓',
        isUser: false,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ]);
  }

  Future<void> sendChatMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    // Add user message
    chatMessages.add(ChatMessage(
      text: text,
      isUser: true,
      time: DateTime.now(),
    ));

    isAiTyping.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      
      String aiResponse = 'سؤال رائع! أنصحك بالتركيز على مراجعة الوحدة الثالثة في الأحياء، حيث تشمل 40% من أسئلة اختبار اليوم. هل تريد مني شرح بعض مبادئ علم الخلية؟';
      
      final String lowerText = text.toLowerCase();
      if (lowerText.contains('رياضيات') || lowerText.contains('تفاضل')) {
        aiResponse = 'بخصوص اختبار الرياضيات المتقدمة اليوم: سيتركز على المشتقات وتطبيقات النهايات. احرص على حل مسألتين تجريبيتين قبل البدء!';
      } else if (lowerText.contains('فيزياء') || lowerText.contains('ميكانيكا')) {
        aiResponse = 'تمت إضافة اختبار الفيزياء المتقدمة (الميكانيكا) في التنبيهات الخاصة بك. يمكنك البدء في حل الاختبار التجريبي الآن لقياس مستواك.';
      } else if (lowerText.contains('مساعدة') || lowerText.contains('مرحبا')) {
        aiResponse = 'أهلاً بك! يمكنني مراجعة المواضيع معك، توفير نصائح سريعة قبل الامتحانات، أو شرح أي مسألة تقف أمامك. ما الذي تود مراجعته الآن؟';
      }

      chatMessages.add(ChatMessage(
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

  @override
  void onClose() {
    sessionCodeController.dispose();
    super.onClose();
  }
}
