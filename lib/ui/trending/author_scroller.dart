import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_trending/assets.dart';
import 'package:github_trending/message_provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AuthorScroller extends StatelessWidget {
  const AuthorScroller(this.trending);
  final Trending trending;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Author>>(
      converter: (store) => trending.builtBy,
      builder: (_, authors) => ActorScrollerContent(authors),
    );
  }
}

class ActorScrollerContent extends StatelessWidget {
  const ActorScrollerContent(this.authors);
  final List<Author> authors;

  @override
  Widget build(BuildContext context) {
    return _ActorScrollerWrapper(
      ListView.builder(
        padding: const EdgeInsets.only(left: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        itemBuilder: (_, int index) {
          final actor = authors[index];
          return _ActorListItem(actor);
        },
      ),
    );
  }
}

class _ActorScrollerWrapper extends StatelessWidget {
  _ActorScrollerWrapper(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const decoration = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0.0, -2.0),
          spreadRadius: 2.0,
          blurRadius: 30.0,
          color: Colors.black12,
        ),
      ],
    );

    final title = Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        MessageProvider.of(context).author,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    return Container(
      decoration: decoration,
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          title,
          const SizedBox(height: 16.0),
          SizedBox(
            height: 110.0,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _ActorListItem extends StatelessWidget {
  _ActorListItem(this.author);
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0,
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          _ActorAvatar(author),
          const SizedBox(height: 8.0),
          Text(
            author.username,
            style: const TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AuthorViewPage extends StatelessWidget {
  AuthorViewPage(this.url, this.title);
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

class _ActorAvatar extends StatelessWidget {
  _ActorAvatar(this.author);
  final Author author;

  void _navigateToAuthorViewPage(BuildContext context) {
    Navigator.push<Null>(
        context,
        MaterialPageRoute(
          builder: (_) => AuthorViewPage(author.href, author.username),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      const Icon(
        Icons.person,
        color: Colors.white,
        size: 26.0,
      ),
    ];
//    final onTap = () => _nav
    final onTap = () => _navigateToAuthorViewPage(context);

    if (author.avatar != null) {
      content.add(ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: ImageAssets.transparentImage,
          image: author.avatar,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 250),
        ),
      ));
    }

    return InkWell(
      child: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: content,
        ),
      ),
      onTap: onTap,
    );
  }
}
