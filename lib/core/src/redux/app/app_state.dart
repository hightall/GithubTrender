import 'package:meta/meta.dart';
import '../github/github_state.dart';

@immutable
class AppState {
  AppState({
    @required this.searchQuery,
    @required this.githubState,
  });

  final String searchQuery;
  final GithubState githubState;

  factory AppState.initial() {
    return AppState(
      searchQuery: null,
      githubState: GithubState.initial(),
    );
  }
}