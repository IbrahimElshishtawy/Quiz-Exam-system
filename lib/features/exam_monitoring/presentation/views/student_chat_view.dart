import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_monitoring_controller.dart';
import '../../domain/entities/student_monitor.dart';
import '../../domain/entities/chat_message.dart';

class StudentChatView extends GetView<ExamMonitoringController> {
  const StudentChatView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: textDark),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'إدارة الاختبارات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            // Left Chat panel (takes remaining space)
            Expanded(
              flex: 7,
              child: Obx(() {
                final s = controller.selectedStudent.value;
                if (s == null) {
                  return Center(
                    child: Text(
                      'الرجاء اختيار طالب للبدء بالمحادثة والتوجيه',
                      style: GoogleFonts.notoKufiArabic(fontSize: 12, color: const Color(0xFF64748B)),
                    ),
                  );
                }

                return Column(
                  children: [
                    // Chat header
                    _buildChatHeader(context, s),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),

                    // Message list
                    Expanded(
                      child: _buildMessageList(s),
                    ),

                    // Quick warning chips
                    _buildQuickWarningChips(s),

                    // Message input field
                    _buildMessageInput(s),
                  ],
                );
              }),
            ),

            // Right Sidebar (takes 30% of width) - Student Selection List
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFFE2E8F0), width: 1),
                  ),
                  color: Color(0xFFF8FAFC),
                ),
                child: Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: TextField(
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 12),
                          onChanged: (val) => controller.setSearchQuery(val),
                          decoration: InputDecoration(
                            hintText: 'بحث عن طالب...',
                            hintStyle: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF94A3B8)),
                            prefixIcon: const Icon(Icons.search_rounded, size: 16, color: Color(0xFF64748B)),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ),

                    // Student items list
                    Expanded(
                      child: Obx(() {
                        final list = controller.filteredStudents;

                        return ListView.separated(
                          itemCount: list.length,
                          separatorBuilder: (context, idx) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
                          itemBuilder: (context, idx) {
                            final s = list[idx];
                            final isSelected = controller.selectedStudent.value?.id == s.id;

                            return InkWell(
                              onTap: () => controller.selectStudent(s),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            s.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.notoKufiArabic(
                                              fontSize: 11,
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                              color: isSelected ? primaryColor : textDark,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            s.violationLogs.isNotEmpty ? s.violationLogs.first.title : 'نشط ومستقر',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.notoKufiArabic(
                                              fontSize: 9,
                                              color: s.violationLogs.isNotEmpty ? const Color(0xFFEF4444) : const Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundColor: isSelected ? primaryColor.withOpacity(0.15) : const Color(0xFFE2E8F0),
                                          child: Text(
                                            s.name.substring(0, 1),
                                            style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: s.liveStatus == 'offline' ? const Color(0xFF64748B) : const Color(0xFF10B981),
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white, width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader(BuildContext context, StudentMonitor student) {
    const textDark = Color(0xFF1E293B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Color(0xFF64748B)),
            onPressed: () => Get.back(), // Go back to monitor view
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                student.name,
                style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    student.liveStatus == 'offline' ? 'أوفلاين' : 'متصل الآن - اختبار مادة الكيمياء',
                    style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF10B981)),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: student.liveStatus == 'offline' ? const Color(0xFF64748B) : const Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(StudentMonitor student) {
    if (student.chatHistory.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'لا توجد رسائل سابقة. يمكنك البدء بإرسال تنبيه أو تحذير للطالب.',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF64748B)),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: student.chatHistory.length,
      itemBuilder: (context, idx) {
        final msg = student.chatHistory[idx];
        return _buildChatBubble(msg);
      },
    );
  }

  Widget _buildChatBubble(ChatMessage msg) {
    final bool isSystem = msg.sender == 'system';
    final bool isTeacher = msg.sender == 'teacher';
    const textDark = Color(0xFF1E293B);

    if (isSystem) {
      // System notification/event bubble (middle centered)
      if (msg.text.contains('قام الطالب بالعودة')) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              msg.text,
              style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF64748B)),
            ),
          ),
        );
      }

      // System warning (blue bubble on left)
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerLeft,
        child: Container(
          maxWidth: 260,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF005BBF), // Standard dark blue for warning
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                msg.text,
                style: GoogleFonts.notoKufiArabic(fontSize: 11.5, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${msg.time} - تم العرض',
                    style: GoogleFonts.ibmPlexSans(fontSize: 9, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    if (isTeacher) {
      // Teacher message (blue bubble on left)
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerLeft,
        child: Container(
          maxWidth: 260,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF005BBF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                msg.text,
                style: GoogleFonts.notoKufiArabic(fontSize: 11.5, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    msg.time,
                    style: GoogleFonts.ibmPlexSans(fontSize: 9, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Student message (grey bubble on right)
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.centerRight,
      child: Container(
        maxWidth: 260,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFFF1F5F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.text,
              style: GoogleFonts.notoKufiArabic(fontSize: 11.5, color: textDark),
            ),
            const SizedBox(height: 4),
            Text(
              msg.time,
              style: GoogleFonts.ibmPlexSans(fontSize: 9, color: const Color(0xFF94A3B8)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickWarningChips(StudentMonitor student) {
    final chips = [
      'التزم بالهدوء',
      'الصوت غير مسموع',
      'عد لتبويب الاختبار',
      'وجهك غير واضح',
    ];

    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        reverse: true, // RTL flow
        children: chips.map((text) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: ActionChip(
              backgroundColor: const Color(0xFFF1F5F9),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              label: Text(
                text,
                style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF475569)),
              ),
              onPressed: () => controller.sendWarning(student.id, text),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMessageInput(StudentMonitor student) {
    const primaryColor = Color(0xFF005BBF);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      color: Colors.white,
      child: Row(
        children: [
          // Send button
          CircleAvatar(
            radius: 22,
            backgroundColor: primaryColor,
            child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              onPressed: () => controller.sendChatMessage(),
            ),
          ),
          const SizedBox(width: 12),
          // Input field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: controller.chatTextController,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'اكتب رسالة توجيه للطالب...',
                  hintStyle: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF94A3B8)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
