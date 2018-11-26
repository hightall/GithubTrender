import 'package:intl/intl.dart';

class Messages {
  String get appName =>Intl.message('Github Trending', name: 'appName');
  String get repo => Intl.message('Repo', name: 'repo');
  String get author => Intl.message('Author', name: 'author');
  String get language => Intl.message('Language', name: 'language');
  String get link => Intl.message('Link', name: 'link');
  String get description => Intl.message("Description", name: "description");
  String get collapseDescription => Intl.message("touch to collapse", name: "collapseDescription");
  String get expandDescription => Intl.message("touch to expand", name: "expandDescription");
}