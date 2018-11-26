import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_trending/ui/trending/trending_detail_page.dart';

class TrendingListTile extends StatelessWidget {
  TrendingListTile(
      this.trending, {
        this.opensTrendingDetails = true,
      }
  );
  final Trending trending;
  final bool opensTrendingDetails;

  void _navigateToTrendDetails(BuildContext context) {
    Navigator.push<Null>(
        context,
        MaterialPageRoute(
          builder: (_) => TrendingDetailPage(trending),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final onTap =
        opensTrendingDetails ? () => _navigateToTrendDetails(context) : null;
    final content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          _ShowStarInfo(trending),
          _DetailedInfo(trending),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(top: 1.0),
      child: Material(
        color: const Color(0xE00D1736),
        child: InkWell(
          child: content,
          onTap: onTap,
        ),
      ),
    );
  }
}

class _ShowStarInfo extends StatelessWidget {
  _ShowStarInfo(
      this.trending,
  );
  final Trending trending;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.0,
          child: Row(
            children: [
              Icon(Icons.trending_up, color: const Color(0xFFFEFEFE)),
              Text(
                "${trending.currentPeriodStars}",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: const Color(0xFFFEFEFE),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _DetailedInfo extends StatelessWidget {
  _DetailedInfo(this.trending);
  final Trending trending;

  @override
  Widget build(BuildContext context) {
    final decoration = const BoxDecoration(
      border: Border(
        left: BorderSide(
          color: Color(0xFF717DAD),
        )
      )
    );

    final content = [
      Text(
        trending.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: const Color(0xFFFEFEFE),
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
          trending.author,
          style: const TextStyle(
            color: Color(0xFF717DAD),
          )
      ),
      Container(
        child: Row(
          children: [
            Icon(Icons.star, color: Colors.white70),
            Text(
              "${trending.stars}",
              style: const TextStyle(
                color: Color(0xFF717DAD),
              ),
            )
          ],
        ),
      ),
      Text(
          trending.description.substring(0, trending.description.length > 30 ? 30 : trending.description.length),
          style: const TextStyle(
            color: Color(0xFF717DAD),
          )
      ),
    ];

    return Expanded(
      child: Container(
        decoration: decoration,
        margin: const EdgeInsets.only(left: 12.0),
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: content,
        ),
      ),
    );
  }
}