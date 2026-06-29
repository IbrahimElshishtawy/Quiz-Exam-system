import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/student_monitor.dart';
import '../../domain/entities/violation_log.dart';
import '../../domain/entities/chat_message.dart';

class MockMonitoringDatasource {
  final List<StudentMonitor> _students = [];
  final _controller = StreamController<List<StudentMonitor>>.broadcast();
  Timer? _timer;

  MockMonitoringDatasource() {
    _initMockData();
    _startSimulatedUpdates();
  }

  void _initMockData() {
    // 1. Mohamed Al-Otaibi (محمد العتيبي)
    _students.add(
      const StudentMonitor(
        id: '202400100',
        name: 'محمد العتيبي',
        avatarUrl: 'assets/images/user1.png',
        liveStatus: 'eye_tracking',
        statusLabel: 'تتبع حركة العين',
        statusColor: Color(0xFFF59E0B), // Warning yellow
        currentQuestion: 24,
        totalQuestions: 50,
        timeRemaining: '01:10:00',
        deviceBattery: 78,
        connectionStatus: 'جيد',
        violationsCount: 1,
        violationLogs: [
          ViolationLog(
            time: '10:18 ص',
            title: 'وضعية الكاميرا غير مناسبة',
            description: 'وجه الطالب غير واضح بالكامل في إطار الكاميرا.',
            type: 'face',
          ),
          ViolationLog(
            time: '09:40 ص',
            title: 'بدء الاختبار',
            description: 'دخل الطالب الجلسة بنجاح.',
            type: 'start',
            isWarning: false,
          ),
        ],
        chatHistory: [
          ChatMessage(
            sender: 'system',
            text: 'يرجى تعديل وضعية الكاميرا، وجهك غير واضح في الإطار الحالي.',
            time: '10:18 ص',
          ),
          ChatMessage(
            sender: 'student',
            text: 'عذراً أستاذ، كنت أحاول تعديل الإضاءة. سأقوم بتعديل الوضعية الآن.',
            time: '10:19 ص',
          ),
          ChatMessage(
            sender: 'system',
            text: 'قام الطالب بالعودة لتبويب الاختبار',
            time: '10:19 ص',
          ),
          ChatMessage(
            sender: 'teacher',
            text: 'بقي 15 دقيقة على نهاية الوقت المحدد. يرجى البدء بمراجعة الإجابات.',
            time: '10:20 ص',
          ),
        ],
      ),
    );

    // 2. Khaled Mansour Al-Suwaidi (خالد منصور السويدي)
    _students.add(
      const StudentMonitor(
        id: '202409821',
        name: 'خالد منصور السويدي',
        avatarUrl: 'assets/images/user2.png',
        liveStatus: 'window_switch',
        statusLabel: 'تبديل نافذة',
        statusColor: Color(0xFFEF4444), // Error red
        currentQuestion: 14,
        totalQuestions: 45,
        timeRemaining: '00:42:15',
        deviceBattery: 82,
        connectionStatus: 'ممتاز',
        violationsCount: 3,
        violationLogs: [
          ViolationLog(
            time: '10:14:22 ص',
            title: 'تبديل علامة التبويب (Tab Switch)',
            description: 'تم رصد محاولة الخروج من نافذة الاختبار لمدة 4 ثوانٍ.',
            type: 'tab',
          ),
          ViolationLog(
            time: '10:08:45 ص',
            title: 'رصد ضجيج ميكروفون',
            description: 'تم اكتشاف أصوات كلام في محيط الطالب.',
            type: 'mic',
          ),
          ViolationLog(
            time: '09:55:12 ص',
            title: 'لم يتم اكتشاف الوجه',
            description: 'اختفاء وجه الطالب من نطاق رؤية الكاميرا.',
            type: 'face',
          ),
          ViolationLog(
            time: '09:30:00 ص',
            title: 'بدء الاختبار',
            description: 'دخل الطالب الجلسة بسلام.',
            type: 'start',
            isWarning: false,
          ),
        ],
        chatHistory: [],
      ),
    );

    // 3. Sarah Mohamed (سارة محمد)
    _students.add(
      const StudentMonitor(
        id: '202400001',
        name: 'سارة محمد',
        avatarUrl: 'assets/images/user3.png',
        liveStatus: 'window_switch',
        statusLabel: 'تبديل نافذة',
        statusColor: Color(0xFFEF4444),
        currentQuestion: 32,
        totalQuestions: 50,
        timeRemaining: '01:53:00',
        deviceBattery: 95,
        connectionStatus: 'ممتاز',
        violationsCount: 2,
        violationLogs: [
          ViolationLog(
            time: '10:02 ص',
            title: 'تبديل علامة التبويب',
            description: 'الخروج من متصفح الاختبار.',
            type: 'tab',
          )
        ],
        chatHistory: [],
      ),
    );

    // 4. Khaled Al-Atiq (خالد العتيق)
    _students.add(
      const StudentMonitor(
        id: '202400002',
        name: 'خالد العتيق',
        avatarUrl: 'assets/images/user4.png',
        liveStatus: 'eye_tracking',
        statusLabel: 'تتبع حركة العين',
        statusColor: Color(0xFFF59E0B),
        currentQuestion: 21,
        totalQuestions: 50,
        timeRemaining: '02:15:00',
        deviceBattery: 60,
        connectionStatus: 'جيد',
        violationsCount: 1,
        violationLogs: [
          ViolationLog(
            time: '10:05 ص',
            title: 'تشتت النظر',
            description: 'النظر المتكرر خارج نطاق الشاشة.',
            type: 'face',
          )
        ],
        chatHistory: [],
      ),
    );

    // 5. Layla Abdullah (ليلى عبدالله)
    _students.add(
      const StudentMonitor(
        id: '202400003',
        name: 'ليلى عبدالله',
        avatarUrl: 'assets/images/user5.png',
        liveStatus: 'active',
        statusLabel: 'نشط ومستقر',
        statusColor: Color(0xFF10B981), // Success green
        currentQuestion: 45,
        totalQuestions: 50,
        timeRemaining: '00:45:00',
        deviceBattery: 89,
        connectionStatus: 'ممتاز',
        violationsCount: 0,
        violationLogs: [],
        chatHistory: [],
      ),
    );

    // 6. Fahad Al-Salem (فهد السالم)
    _students.add(
      const StudentMonitor(
        id: '202400004',
        name: 'فهد السالم',
        avatarUrl: 'assets/images/user6.png',
        liveStatus: 'active',
        statusLabel: 'نشط ومستقر',
        statusColor: Color(0xFF10B981),
        currentQuestion: 18,
        totalQuestions: 50,
        timeRemaining: '01:20:00',
        deviceBattery: 45,
        connectionStatus: 'ممتاز',
        violationsCount: 0,
        violationLogs: [],
        chatHistory: [],
      ),
    );

    // 7. Abeer Al-Shammari (عبير الشمري)
    _students.add(
      const StudentMonitor(
        id: '202400005',
        name: 'عبير الشمري',
        avatarUrl: 'assets/images/user7.png',
        liveStatus: 'offline',
        statusLabel: 'أوفلاين',
        statusColor: Color(0xFF64748B), // Neutral slate
        currentQuestion: 12,
        totalQuestions: 50,
        timeRemaining: '01:30:00',
        deviceBattery: 10,
        connectionStatus: 'ضعيف',
        violationsCount: 0,
        violationLogs: [],
        chatHistory: [],
      ),
    );

    // 8. Sarah Al-Otaibi (سارة العتيبي)
    _students.add(
      const StudentMonitor(
        id: '221045',
        name: 'سارة العتيبي',
        avatarUrl: 'assets/images/user8.png',
        liveStatus: 'window_switch',
        statusLabel: 'تبديل نافذة',
        statusColor: Color(0xFFEF4444),
        currentQuestion: 29,
        totalQuestions: 45,
        timeRemaining: '00:55:00',
        deviceBattery: 75,
        connectionStatus: 'ممتاز',
        violationsCount: 2,
        violationLogs: [
          ViolationLog(
            time: '10:10 ص',
            title: 'تبديل نافذة',
            description: 'الخروج من تطبيق الاختبار.',
            type: 'tab',
          )
        ],
        chatHistory: [],
      ),
    );

    // 9. Fahad Al-Qahtani (فهد القحطاني)
    _students.add(
      const StudentMonitor(
        id: '221099',
        name: 'فهد القحطاني',
        avatarUrl: 'assets/images/user9.png',
        liveStatus: 'eye_tracking',
        statusLabel: 'تتبع حركة العين',
        statusColor: Color(0xFFF59E0B),
        currentQuestion: 30,
        totalQuestions: 45,
        timeRemaining: '01:02:00',
        deviceBattery: 92,
        connectionStatus: 'جيد',
        violationsCount: 1,
        violationLogs: [
          ViolationLog(
            time: '10:08 ص',
            title: 'تشتت النظر',
            description: 'النظر بعيداً عن الكاميرا.',
            type: 'face',
          )
        ],
        chatHistory: [],
      ),
    );

    // 10. Nora Al-Mutairi (نورة المطيري)
    _students.add(
      const StudentMonitor(
        id: '221156',
        name: 'نورة المطيري',
        avatarUrl: 'assets/images/user10.png',
        liveStatus: 'active',
        statusLabel: 'نشط ومستقر',
        statusColor: Color(0xFF10B981),
        currentQuestion: 38,
        totalQuestions: 45,
        timeRemaining: '00:50:00',
        deviceBattery: 80,
        connectionStatus: 'ممتاز',
        violationsCount: 0,
        violationLogs: [],
        chatHistory: [],
      ),
    );

    // 11. Khaled Al-Shammari (خالد الشمري)
    _students.add(
      const StudentMonitor(
        id: '221342',
        name: 'خالد الشمري',
        avatarUrl: 'assets/images/user11.png',
        liveStatus: 'offline',
        statusLabel: 'أوفلاين',
        statusColor: Color(0xFF64748B),
        currentQuestion: 5,
        totalQuestions: 45,
        timeRemaining: '01:15:00',
        deviceBattery: 4,
        connectionStatus: 'ضعيف',
        violationsCount: 1,
        violationLogs: [
          ViolationLog(
            time: '09:45 ص',
            title: 'انقطاع الاتصال',
            description: 'انفصال جهاز الطالب عن خادم الاختبار.',
            type: 'tab',
          )
        ],
        chatHistory: [],
      ),
    );
  }

  void _startSimulatedUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      // Simulate small question updates or connectivity changes
      for (int i = 0; i < _students.length; i++) {
        final s = _students[i];
        if (s.liveStatus != 'offline' && s.currentQuestion < s.totalQuestions) {
          // 30% chance to advance question
          if (timer.tick % 3 == 0) {
            _students[i] = s.copyWith(
              currentQuestion: s.currentQuestion + 1,
              deviceBattery: (s.deviceBattery - 1).clamp(0, 100),
            );
          }
        }
      }
      _controller.add(List.from(_students));
    });
  }

  Stream<List<StudentMonitor>> getMonitoringStudents() {
    // Immediate first emission
    Future.microtask(() => _controller.add(List.from(_students)));
    return _controller.stream;
  }

  Future<StudentMonitor> getStudentDetails(String id) async {
    return _students.firstWhere((s) => s.id == id);
  }

  Future<void> sendWarning(String studentId, String message) async {
    final idx = _students.indexWhere((s) => s.id == studentId);
    if (idx != -1) {
      final s = _students[idx];
      
      final now = DateTime.now();
      final timeStr = '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'م' : 'ص'}';

      final updatedLogs = List<ViolationLog>.from(s.violationLogs);
      updatedLogs.insert(
        0,
        ViolationLog(
          time: timeStr,
          title: 'تحذير من المعلم',
          description: message,
          type: 'face',
        ),
      );

      final updatedChats = List<ChatMessage>.from(s.chatHistory);
      updatedChats.add(
        ChatMessage(
          sender: 'teacher',
          text: message,
          time: timeStr,
        ),
      );

      _students[idx] = s.copyWith(
        violationLogs: updatedLogs,
        chatHistory: updatedChats,
        violationsCount: s.violationsCount + 1,
      );

      _controller.add(List.from(_students));
    }
  }

  Future<void> broadcastWarning(String message) async {
    final now = DateTime.now();
    final timeStr = '${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'م' : 'ص'}';

    for (int i = 0; i < _students.length; i++) {
      final s = _students[i];
      if (s.liveStatus != 'offline') {
        final updatedChats = List<ChatMessage>.from(s.chatHistory);
        updatedChats.add(
          ChatMessage(
            sender: 'teacher',
            text: 'تنبيه جماعي: $message',
            time: timeStr,
          ),
        );
        _students[i] = s.copyWith(chatHistory: updatedChats);
      }
    }
    _controller.add(List.from(_students));
  }

  Future<void> togglePauseExam() async {
    // Simulate pausing/status toggles in live data
    _controller.add(List.from(_students));
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
