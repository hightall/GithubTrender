import 'github_state.dart';
import 'github_actions.dart';
import 'package:github_trending/core/src/models/loading_status.dart';

GithubState githubReducer(GithubState state, dynamic action) {
  if (action is SetLanguages) {
    return state.copyWith(
      languages: action.languages,
//      currentLanguage: action.languages.length > 0 ? (state?.currentLanguage  ?? action.languages[0]) : state.currentLanguage,
    );
  } else if (action is SetCurrentLanguage) {
    return state.copyWith(
      currentLanguage: action.language,
    );
  } else if (action is SetRepoTrending) {
    return state.copyWith(
      repoTrending: action.trending,
      loadingStatus: LoadingStatus.success,
    );
  } else if (action is FetchingTrendingAction) {
    return state.copyWith(
      loadingStatus: LoadingStatus.loading,
    );
  }

  return state;
}