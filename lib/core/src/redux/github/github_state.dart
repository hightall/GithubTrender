import 'package:meta/meta.dart';
import 'package:github_trending/core/src/models/language.dart';
import 'package:github_trending/core/src/models/trending.dart';
import 'package:github_trending/core/src/models/loading_status.dart';

@immutable
class GithubState {
  GithubState({
    @required this.languages,
    @required this.repoTrending,
    @required this.currentLanguage,
    @required this.loadingStatus,
  });

  final Language currentLanguage;
  final List<Language> languages;
  final List<Trending> repoTrending;
  final LoadingStatus loadingStatus;

  factory GithubState.initial() {
    return GithubState(
      loadingStatus: LoadingStatus.idle,
      languages: [],
      repoTrending: [],
      currentLanguage: null,
    );
  }

  GithubState copyWith({
    LoadingStatus loadingStatus,
    List<Language> languages,
    List<Trending> repoTrending,
    Language currentLanguage,
  }) {
    return GithubState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      languages: languages ?? this.languages,
      repoTrending: repoTrending ?? this.repoTrending,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}