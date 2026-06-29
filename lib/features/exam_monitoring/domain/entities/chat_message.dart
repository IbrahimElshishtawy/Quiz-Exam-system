class ChatMessage {
  final String sender; // 'system' | 'student' | 'teacher'
  final String text;
  final String time;
  final bool isRead;

  const ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
    this.isRead = true,
  });
}
