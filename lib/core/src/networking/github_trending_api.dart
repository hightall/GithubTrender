import 'dart:async';
import 'package:dio/dio.dart';
import '../models/language.dart';
import '../parsers/language.dart';
import 'package:github_trending/core/src/parsers/trending.dart';
import 'package:github_trending/core/src/models/trending.dart';

class GithubTrendingApi {
  static bool useChinese = false;
  static String repoUrl = "https://github-trending-api.now.sh/repositories";
  Dio dio = new Dio();

  Future<List<Language>> getLanguages(String languageType) async {
    Response response = await dio.get("https://github-trending-api.now.sh/languages");
    return LanguageParser.parse(response.data[languageType]);
  }

  Future<List<Trending>> getTrending(String language, String since) async {
    Response response = await dio.get(repoUrl, data: {
      "language": language,
      "since": since
    });
    final List<dynamic> data = response.data;
    data.sort((a, b) => a["currentPeriodStars"].compareTo(b["currentPeriodStars"]));
    return TrendingParser.parse(data.reversed.toList());
  }
}