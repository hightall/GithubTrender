import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LanguageList extends StatelessWidget {
  LanguageList({
    @required this.onLanguageTapped,
  });
  final VoidCallback onLanguageTapped;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TrendingPageViewModel> (
      distinct: true,
      converter: (store) => TrendingPageViewModel.fromStore(store, TrendingListType.repo),
      builder: (BuildContext context, TrendingPageViewModel viewModel) {
        return LanguageListContent(
          onLanguageTapped: onLanguageTapped,
          viewModel: viewModel,
        );
      },
    );
  }
}

class LanguageListContent extends StatelessWidget {
  LanguageListContent({
    @required this.onLanguageTapped,
    @required this.viewModel,
  });
  final VoidCallback onLanguageTapped;
  final TrendingPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: viewModel.languages.length,
        itemBuilder: (BuildContext context, int index) {
          final language = viewModel.languages[index];
          return Material(
            color: Colors.transparent,
            child: ListTile(
              onTap: () {
                viewModel.changeCurrentLanguage(language);
                onLanguageTapped();
              },
              title: Text(
                language.name,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}