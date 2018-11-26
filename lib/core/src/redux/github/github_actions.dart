import '../../models/language.dart';
import 'package:github_trending/core/src/models/trending.dart';

class SetLanguages {
  SetLanguages(this.languages);
  final List<Language> languages;
}

class FetchRepoTrending {
  FetchRepoTrending(this.language, this.since);
  final String language;
  final String since;
}

class ChangeCurrentLanguage {
  ChangeCurrentLanguage(this.language);
  final Language language;
}

class SetCurrentLanguage {
  SetCurrentLanguage(this.language);
  final Language language;
}

class SetRepoTrending {
  SetRepoTrending(this.trending);
  final List<Trending> trending;
}

class FetchingTrendingAction {}