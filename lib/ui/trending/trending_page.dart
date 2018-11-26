import 'package:github_trending/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_trending/ui/common/loading_view.dart';
import 'package:github_trending/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:github_trending/ui/trending/trending_list.dart';

class TrendingPage extends StatelessWidget {
  TrendingPage(this.listType);
  final TrendingListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TrendingPageViewModel> (
      distinct: true,
//      onInit: (store) => store.dispatch(FetchRepoTrending(store.state.githubState.currentLanguage?.urlParam ?? 'javascript', 'week')),
      converter: (store) => TrendingPageViewModel.fromStore(store, listType),
      builder: (_, viewModel) => TrendingPageContent(viewModel, listType),
    );
//    return StoreConnector<AppState>()
  }
}

class TrendingPageContent extends StatelessWidget {
  TrendingPageContent(this.viewModel, this.listType);
  final TrendingPageViewModel viewModel;
  final TrendingListType listType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: LoadingView(
              status: viewModel.status,
              loadingContent: const PlatformAdaptiveProgressIndicator(),
              errorContent: Text("Error"),
              successContent: TrendingList(viewModel.status, viewModel.repoTrendingList)
          ),
        )
      ],
    );
  }
}