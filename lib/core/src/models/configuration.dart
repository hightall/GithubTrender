import 'package:github_trending/core/src/models/language.dart';
import 'package:github_trending/core/src/parsers/language.dart';

class Configuration {
  Configuration({this.popular, this.all});
  final List<Language> popular;
  final List<Language> all;

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return new Configuration(
      popular: LanguageParser.parse(json["language"]["popular"]),
      all: LanguageParser.parse(json["language"]["all"]),
    );
  }
}