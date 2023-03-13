enum LanguageType {
  english,
  arabic,
}

const String arabic = 'ar';
const String english = 'en';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}
