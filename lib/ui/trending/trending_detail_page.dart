import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:github_trending/ui/trending/trending_details_scroll_effects.dart';
import 'package:github_trending/assets.dart';
import 'package:github_trending/ui/trending/trending_backdrop_photo.dart';
import 'package:github_trending/ui/common/widget_utils.dart';
import 'package:github_trending/ui/trending/trending_list_tile.dart';
import 'package:github_trending/message_provider.dart';
import 'package:github_trending/ui/trending/trending_description_widget.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:github_trending/ui/trending/author_scroller.dart';

class GithubViewPage extends StatelessWidget {
  GithubViewPage(this.url, this.title);
  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),
      ),
    );
  }
}

class TrendingDetailPage extends StatefulWidget {
  TrendingDetailPage(
      this.trending,
  );
  final Trending trending;

  @override
  _TrendingDetailPageState createState() => _TrendingDetailPageState();
}

class _TrendingDetailPageState extends State<TrendingDetailPage> {
  ScrollController _scrollController;
  TrendingDetailsScrollEffects _scrollEffects;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollEffects = TrendingDetailsScrollEffects();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    setState(() {
      _scrollEffects.updateScrollOffset(context, _scrollController.offset);
    });
  }

  Widget _buildTrendingInformation() {
    if (widget.trending != null) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TrendingListTile(
            widget.trending,
            opensTrendingDetails: false,
          ),
        ),
      );
    }

    return null;
  }

  Widget _buildDescription() {
    if (widget.trending.description != null) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: widget.trending == null ? 12.0 : 0.0,
          bottom: 16.0,
        ),
        child: DescriptionWidget(widget.trending),
      ) ;
    }
    return null;
  }

  Widget _buildGallery() => Container(color: Colors.white, height: 500.0);

  Widget _buildTrendingBackdrop() {
    return Positioned(
      top: _scrollEffects.headerOffset,
      child: TrendingBackdropPhoto(
          trending: widget.trending,
          scrollEffects: _scrollEffects
      ),
    );
  }

  Widget _buildStatusBarBackground() {
    final statusBarColor = Theme.of(context).primaryColor;

    return Container(
      height: _scrollEffects.statusBarHeight,
      color: statusBarColor,
    );
  }

  Widget _buildAuthorScroller() =>
      widget.trending.builtBy.isNotEmpty ? AuthorScroller(widget.trending) : null;

  @override
  Widget build(BuildContext context) {
    final content = <Widget> [
      _Header(widget.trending),
    ];

//    addIfNonNull(_buildTrendingInformation(), content);
    addIfNonNull(_buildDescription(), content);
//    addIfNonNull(_buildGallery(), content);
    addIfNonNull(_buildAuthorScroller(), content);

    content.add(const SizedBox(height: 32.0));

    final backgroundImage = Positioned.fill(
      child: Image.asset(
        ImageAssets.backgroundImage,
        fit: BoxFit.cover,
      ),
    );

    final slivers = CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(delegate: SliverChildListDelegate(content))
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Stack(
        children: [
          backgroundImage,
          _buildTrendingBackdrop(),
          slivers,
          _BackButton(_scrollEffects),
          _buildStatusBarBackground(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  _Header(this.trending);
  final Trending trending;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 225.0,
          margin: const EdgeInsets.only(bottom: 132.0),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: Colors.white,
            height: 132.0,
          ),
        ),
        Positioned(
          top: 238.0,
          left: 16.0,
          right: 16.0,
          child: _TrendingInfo(trending),
        )
      ],
    );
  }
}

class _TrendingInfo extends StatelessWidget {
  _TrendingInfo(this.trending);
  final Trending trending;

  void _navigateToGithubViewPage(BuildContext context) {
    Navigator.push<Null>(
        context,
        MaterialPageRoute(
          builder: (_) => GithubViewPage(trending.url, trending.name),
        )
    );
  }

  List<Widget> _buildTitleAndInfo(BuildContext context) {
    final messages = MessageProvider.of(context);
    final onTap = () => _navigateToGithubViewPage(context);
    return [
      Text(
        trending.name,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 8.0,),
      Text(
        '${messages.language}: ${trending.language} | ${messages.author}: ${trending.author}',
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 8.0),
      Row(
        children: [
          Icon(
            Icons.star,
            size: 16.0,
          ),
          Text(
            '${trending.stars} | ',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.trending_up,
            size: 16.0,
          ),
          Text(
            '${trending.currentPeriodStars} | ',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'forks: ${trending.forks}',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      Row(
        children: [
          Text(
            '${messages.link}: ',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            child: RichText(
              text: TextSpan(
                text: trending.url,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: onTap,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[]..addAll(
      _buildTitleAndInfo(context),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }
}

class _BackButton extends StatelessWidget {
  _BackButton(this.scrollEffects);
  final TrendingDetailsScrollEffects scrollEffects;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 4.0,
      child: IgnorePointer(
        ignoring: scrollEffects.backButtonOpacity == 0.0,
        child: Material(
          type: MaterialType.circle,
          color: Colors.transparent,
          child: BackButton(
            color: Colors.white.withOpacity(
              scrollEffects.backButtonOpacity * 0.9,
            ),
          ),
        ),
      ),
    );
  }
}