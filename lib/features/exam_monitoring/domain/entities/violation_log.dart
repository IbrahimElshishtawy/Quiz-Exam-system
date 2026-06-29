class ViolationLog {
  final String time;
  final String title;
  final String description;
  final String type; // 'tab' | 'mic' | 'face' | 'start'
  final bool isWarning;

  const ViolationLog({
    required this.time,
    required this.title,
    required this.description,
    required this.type,
    this.isWarning = true,
  });
}
