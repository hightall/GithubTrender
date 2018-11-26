import 'package:meta/meta.dart';

enum TrendingListType {
  repo,
  author,
}

class Author {
  Author({
    this.username,
    this.href,
    this.avatar,
  });
  final String username;
  final String href;
  final String avatar;
}

class Trending {
  Trending({
    this.author,
    this.name,
    this.url,
    this.description,
    this.language,
    this.stars,
    this.forks,
    this.currentPeriodStars,
    this.builtBy,
  });

  final String author;
  final String name;
  final String url;
  final String description;
  final String language;
  final int stars;
  final int forks;
  final int currentPeriodStars;
  final List<Author> builtBy;
}