import 'dart:collection';
import 'package:reselect/reselect.dart';
import 'package:github_trending/core/src/redux/app/app_state.dart';
import 'package:github_trending/core/src/models/trending.dart';
import 'package:github_trending/core/src/models/language.dart';

final repoTrendingSelector = createSelector1((AppState state) => state.githubState.repoTrending, _trendingFilter);

final languageSelector = createSelector1((AppState state) => state.githubState.languages, _languageFilter);

List<Trending> _trendingFilter(List<Trending> trending) {
  return trending;
}

List<Language> _languageFilter(List<Language> languages) {
  return languages;
}
