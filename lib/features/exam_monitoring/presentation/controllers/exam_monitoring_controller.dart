import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/repositories/monitoring_repository.dart';
import '../../domain/entities/student_monitor.dart';

class ExamMonitoringController extends GetxController {
  final MonitoringRepository _repository;

  ExamMonitoringController(this._repository);

  final RxInt currentTabIndex = 0.obs; // 0: Dashboard, 1: Live Grid
  final RxList<StudentMonitor> allStudents = <StudentMonitor>[].obs;
  final RxList<StudentMonitor> filteredStudents = <StudentMonitor>[].obs;
  final RxString activeFilter = 'all'.obs; // 'all', 'active', 'alerts', 'violations', 'offline'
  final RxString searchQuery = ''.obs;
  final Rxn<StudentMonitor> selectedStudent = Rxn<StudentMonitor>();
  final RxBool isExamPaused = false.obs;

  final TextEditingController chatTextController = TextEditingController();
  StreamSubscription<List<StudentMonitor>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _startListening();
  }

  void _startListening() {
    _subscription = _repository.getMonitoringStudents().listen((list) {
      allStudents.assignAll(list);
      _applyFilter();
      
      // Update selectedStudent details in real time if selected
      if (selectedStudent.value != null) {
        final updated = list.firstWhereOrNull((s) => s.id == selectedStudent.value!.id);
        if (updated != null) {
          selectedStudent.value = updated;
        }
      }
    });
  }

  void setFilter(String filter) {
    activeFilter.value = filter;
    _applyFilter();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    _applyFilter();
  }

  void _applyFilter() {
    final query = searchQuery.value.trim().toLowerCase();
    
    final temp = allStudents.where((s) {
      // 1. Filter by search query
      final matchesQuery = query.isEmpty ||
          s.name.toLowerCase().contains(query) ||
          s.id.contains(query);

      if (!matchesQuery) return false;

      // 2. Filter by tab status
      switch (activeFilter.value) {
        case 'active':
          return s.liveStatus == 'active';
        case 'alerts':
          return s.liveStatus == 'eye_tracking';
        case 'violations':
          return s.liveStatus == 'window_switch';
        case 'offline':
          return s.liveStatus == 'offline';
        case 'all':
        default:
          return true;
      }
    }).toList();

    filteredStudents.assignAll(temp);
  }

  void selectStudent(StudentMonitor student) {
    selectedStudent.value = student;
  }

  Future<void> sendWarning(String studentId, String message) async {
    if (message.trim().isEmpty) return;
    await _repository.sendWarning(studentId, message);
    
    Get.snackbar(
      'تم إرسال التحذير',
      'تم إرسال التنبيه للطالب بنجاح.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
    );
  }

  Future<void> sendChatMessage() async {
    final text = chatTextController.text.trim();
    if (text.isEmpty || selectedStudent.value == null) return;

    final studentId = selectedStudent.value!.id;
    await _repository.sendWarning(studentId, text);
    chatTextController.clear();
  }

  Future<void> broadcastWarning(String message) async {
    if (message.trim().isEmpty) return;
    await _repository.broadcastWarning(message);

    Get.snackbar(
      'تنبيه جماعي',
      'تم بث التحذير لجميع الطلاب النشطين.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF005BBF),
      colorText: Colors.white,
    );
  }

  void togglePauseExam() {
    isExamPaused.toggle();
    _repository.togglePauseExam();
    
    Get.snackbar(
      isExamPaused.value ? 'تم إيقاف الاختبار' : 'تم استئناف الاختبار',
      isExamPaused.value ? 'تم إيقاف جلسة الاختبار مؤقتاً لجميع الطلاب.' : 'تم استئناف جلسة الاختبار لجميع الطلاب.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: isExamPaused.value ? const Color(0xFF64748B) : const Color(0xFF10B981),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    chatTextController.dispose();
    super.onClose();
  }
}
