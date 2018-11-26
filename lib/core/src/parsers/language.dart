import '../models/language.dart';

class LanguageParser {
  static List<Language> parse(List<dynamic> languages) {
    return languages.map((language) {
      return Language(
        name: language["name"],
        urlParam: language["urlParam"],
      );
    }).toList();
  }
}