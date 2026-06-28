class OnboardingPageEntity {
  final int index;
  final String title;
  final String subtitle;
  final String? badgeText;

  const OnboardingPageEntity({
    required this.index,
    required this.title,
    required this.subtitle,
    this.badgeText,
  });
}
