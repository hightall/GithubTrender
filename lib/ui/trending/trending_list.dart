import 'dart:async';
import 'package:flutter/material.dart';
import 'package:github_trending/core/core.dart';
import 'package:github_trending/ui/common/loading_view.dart';
import 'package:github_trending/ui/trending/trending_list_tile.dart';

class TrendingList extends StatefulWidget {
  static const Key contentKey = Key('content');

  TrendingList(this.status, this.trending);
  final LoadingStatus status;
  final List<Trending> trending;

  @override
  _TrendingListState createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  List<Trending> _trending = [];
  bool _showEmptyView = false;

  @override
  void initState() {
    super.initState();
    _trending = widget.trending;
    _showEmptyView = _trending.isEmpty && widget.status == LoadingStatus.success;
  }

  @override
  void didUpdateWidget(TrendingList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.status != LoadingStatus.success) {
      Timer(
        LoadingView.successContentAnimationDuration,
        () => _trending = widget.trending,
      );
    } else if (widget.status == LoadingStatus.success) {
      _trending = widget.trending;
    }

    _showEmptyView = widget.trending.isEmpty && widget.status == LoadingStatus.success;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      key: TrendingList.contentKey,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80.0),
        itemCount: _trending.length,
        itemBuilder: (BuildContext context, int index) {
          final trendingItem = _trending[index];
          return TrendingListTile(trendingItem);
        },
      ),
    );
  }
}