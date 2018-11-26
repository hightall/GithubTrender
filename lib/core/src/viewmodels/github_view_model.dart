import 'package:github_trending/core/src/models/trending.dart';
import 'package:github_trending/core/src/models/language.dart';
import 'package:github_trending/core/src/redux/github/github_selectors.dart';
import 'package:github_trending/core/src/redux/app/app_state.dart';
import 'package:github_trending/core/src/redux/github/github_actions.dart';
import 'package:github_trending/core/src/models/loading_status.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class TrendingPageViewModel {
  TrendingPageViewModel({
    @required this.repoTrendingList,
    @required this.languages,
    @required this.changeCurrentLanguage,
    @required this.status,
  });
  final List<Trending> repoTrendingList;
  final List<Language> languages;
  final Function(Language) changeCurrentLanguage;
  final LoadingStatus status;

  static TrendingPageViewModel fromStore(
      Store<AppState> store,
      TrendingListType type,
      ) {
    return TrendingPageViewModel(
      repoTrendingList: repoTrendingSelector(store.state),
      languages: languageSelector(store.state),
      status: store.state.githubState.loadingStatus,
      changeCurrentLanguage: (language) {
        store.dispatch(ChangeCurrentLanguage(language));
      },
    );
  }
}