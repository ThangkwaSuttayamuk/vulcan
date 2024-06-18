class LanguageState {
  final String language;
  final String? saveLanguage;

  LanguageState({
    this.language = 'en',
    this.saveLanguage,
  });

  LanguageState copyWith({String? language, String? saveLanguage}) {
    return LanguageState(
        language: language ?? this.language,
        saveLanguage: saveLanguage ?? this.saveLanguage);
  }
}
