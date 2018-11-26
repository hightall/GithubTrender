import 'package:redux/redux.dart';
import 'package:key_value_store/key_value_store.dart';
import 'app/app_state.dart';
import 'app/app_reducer.dart';
import 'github/github_middleware.dart';
import '../networking/github_trending_api.dart';


Store<AppState> createStore(KeyValueStore keyValueStore) {
  final githubApi = GithubTrendingApi();

  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      GithubMiddleware(keyValueStore, githubApi),
    ]
  );
}