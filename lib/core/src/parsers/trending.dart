import '../models/trending.dart';

class AuthorParser {
  static List<Author> parse(List<dynamic> authors) {
    return authors.map((author) {
      return Author(
        username: author["username"],
        href: author["href"],
        avatar: author["avatar"],
      );
    }).toList();
  }
}

class TrendingParser {
  static List<Trending> parse(List<dynamic> trendingList) {
    return trendingList.map((trending) {
      return Trending(
        author: trending["author"],
        name: trending["name"],
        url: trending["url"],
        description: trending["description"],
        language: trending["language"],
        stars: trending["stars"],
        forks: trending["forks"],
        currentPeriodStars: trending["currentPeriodStars"],
        builtBy: AuthorParser.parse(trending["builtBy"]),
      );
    }).toList();
  }
}