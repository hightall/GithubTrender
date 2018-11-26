import 'dart:async';
import 'package:redux/redux.dart';
import 'package:key_value_store/key_value_store.dart';
import 'github_actions.dart';
import '../app/app_state.dart';
import '../_common/common_actions.dart';
import '../../networking/github_trending_api.dart';
import '../../models/language.dart';
import 'package:github_trending/utils/load_config.dart';

class GithubMiddleware extends MiddlewareClass<AppState> {
  GithubMiddleware(this.keyValueStore, this.api);

  final KeyValueStore keyValueStore;
  final GithubTrendingApi api;

  @override
  Future<Null> call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is InitAction) {
      await _init(action, next, store);
    } else if (action is FetchRepoTrending) {
      await _fetchTrending(action.language, action.since, next);
    } else if (action is ChangeCurrentLanguage) {
      next(SetCurrentLanguage(action.language));
      await _fetchTrending(action.language.urlParam, "weekly", next);
    } else {
      next(action);
    }
  }

  Future<void> _init(InitAction action, NextDispatcher next, Store<AppState> store) async {
    final configuration = await loadConfig();
    final languages = [configuration.popular, configuration.all].expand((x) => x).toList();
    next(SetLanguages(languages));
    next(SetCurrentLanguage(configuration.popular[0]));
    final currentLanguage = store.state.githubState?.currentLanguage ?? configuration.popular[0];
    await _fetchTrending(currentLanguage.urlParam, 'weekly', next);
  }

  Future<List<Language>> _fetchLanguages(String languageType) async {
    return await api.getLanguages(languageType);
  }

  Future<void> _fetchTrending(String language, String since, NextDispatcher next) async {
    next(FetchingTrendingAction());
    final trendingList = await api.getTrending(language, since);
    next(SetRepoTrending(trendingList));
  }
}