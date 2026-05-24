class AppLanguageOption {
  const AppLanguageOption({
    required this.code,
    required this.labelKey,
    required this.flagUrl,
  });

  final String code;
  final String labelKey;
  final String flagUrl;
}

abstract final class AppLanguages {
  static const List<AppLanguageOption> options = [
    AppLanguageOption(
      code: 'ar',
      labelKey: 'arabic',
      flagUrl: 'https://flagcdn.com/w80/eg.png',
    ),
    AppLanguageOption(
      code: 'en',
      labelKey: 'english',
      flagUrl: 'https://flagcdn.com/w80/us.png',
    ),
  ];

  static AppLanguageOption? findByCode(String code) {
    for (final option in options) {
      if (option.code == code) return option;
    }
    return null;
  }
}
