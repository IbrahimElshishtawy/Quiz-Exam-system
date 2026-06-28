class BuilderActivityEntity {
  final String id;
  final String message;
  final String timeAgo;
  final String iconType; // 'flag', 'check', 'person'

  BuilderActivityEntity({
    required this.id,
    required this.message,
    required this.timeAgo,
    required this.iconType,
  });
}
