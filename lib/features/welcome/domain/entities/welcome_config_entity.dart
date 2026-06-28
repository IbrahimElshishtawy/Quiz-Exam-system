class WelcomeConfigEntity {
  final String languageCode;
  final String role; // 'student' or 'instructor'

  const WelcomeConfigEntity({
    required this.languageCode,
    required this.role,
  });
}
