import 'app_state.dart';
import '../github/github_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    searchQuery: '',
    githubState: githubReducer(state.githubState, action),
  );
}
