import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/core.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_trending/ui/main_page.dart';
import 'package:github_trending/message_provider.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  final prefs = await SharedPreferences.getInstance();
  final keyValueStore = FlutterKeyValueStore(prefs);
  final store = createStore(keyValueStore);
  runApp(GitTrendingApp(store));
}

final supportedLocales = const [
  const Locale('en', 'US'),
  const Locale('zh', 'Zh-CN'),
];

final localizationsDelegates = <LocalizationsDelegate>[
  const GithubTrendingLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];

class GitTrendingApp extends StatefulWidget {
  GitTrendingApp(this.store);
  final Store<AppState> store;

  @override
  _GitTrendingAppState createState() => _GitTrendingAppState();
  // This widget is the root of your application.
}

class _GitTrendingAppState extends State<GitTrendingApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
      return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'Github Trending',
          theme: ThemeData(
            primaryColor: const Color(0xFF1C306D),
            accentColor: const Color(0xFFFFAD32),
            scaffoldBackgroundColor: Colors.transparent,
          ),
          home: MainPage(),
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
        ),
      );
  }
}
