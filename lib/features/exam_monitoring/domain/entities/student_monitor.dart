import 'package:flutter/material.dart';
import 'violation_log.dart';
import 'chat_message.dart';

class StudentMonitor {
  final String id;
  final String name;
  final String avatarUrl;
  final String liveStatus; // 'window_switch' | 'eye_tracking' | 'active' | 'offline'
  final String statusLabel; // 'تبديل نافذة' | 'تتبع حركة العين' | 'نشط ومستقر' | 'أوفلاين'
  final Color statusColor;
  final int currentQuestion;
  final int totalQuestions;
  final String timeRemaining;
  final int deviceBattery;
  final String connectionStatus; // 'ممتاز' | 'جيد' | 'ضعيف'
  final int violationsCount;
  final List<ViolationLog> violationLogs;
  final List<ChatMessage> chatHistory;

  const StudentMonitor({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.liveStatus,
    required this.statusLabel,
    required this.statusColor,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.timeRemaining,
    required this.deviceBattery,
    required this.connectionStatus,
    required this.violationsCount,
    required this.violationLogs,
    required this.chatHistory,
  });

  StudentMonitor copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    String? liveStatus,
    String? statusLabel,
    Color? statusColor,
    int? currentQuestion,
    int? totalQuestions,
    String? timeRemaining,
    int? deviceBattery,
    String? connectionStatus,
    int? violationsCount,
    List<ViolationLog>? violationLogs,
    List<ChatMessage>? chatHistory,
  }) {
    return StudentMonitor(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      liveStatus: liveStatus ?? this.liveStatus,
      statusLabel: statusLabel ?? this.statusLabel,
      statusColor: statusColor ?? this.statusColor,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      deviceBattery: deviceBattery ?? this.deviceBattery,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      violationsCount: violationsCount ?? this.violationsCount,
      violationLogs: violationLogs ?? this.violationLogs,
      chatHistory: chatHistory ?? this.chatHistory,
    );
  }
}
