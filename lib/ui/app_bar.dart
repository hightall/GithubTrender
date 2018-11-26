import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_trending/message_provider.dart';
import 'package:github_trending/ui/language_list/language_selector_popup.dart';
import 'package:github_trending/core/src/models/language.dart';

class GithubTrendingAppBar extends StatefulWidget {
  @override
  _GithubTrendingAppBarState createState() => _GithubTrendingAppBarState();
}

class _GithubTrendingAppBarState extends State<GithubTrendingAppBar> with SingleTickerProviderStateMixin {
  bool _languagesOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleLanguages() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      _setLanguagesOpenFlag(false);
    } else {
      _setLanguagesOpenFlag(true);

      await Navigator.push(context, LanguageSelectorPopup());

      _setLanguagesOpenFlag(false);
    }
  }

  void _setLanguagesOpenFlag(bool open) {
    setState(() {
      _languagesOpen = open;
    });
  }

  List<Widget> _buildActions() {
    return [
      _LanguageIconButton(_languagesOpen, _toggleLanguages)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: _Title(messages.appName),
      actions: _buildActions(),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.appName);
  final String appName;

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);

    final subtitle = StoreConnector<AppState, Language> (
      converter: (store) => store.state.githubState.currentLanguage,
      builder: (BuildContext context, Language currentLanguage) {
        return Text(
          "${messages.language}: ${currentLanguage?.name ?? ''}",
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        );
      },
    );
    final title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appName),
        subtitle,
      ],
    );
    return GestureDetector(
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 28.0, height: 28.0),
          const SizedBox(width: 8.0),
          title,
        ],
      ),
    );
  }
}

class _LanguageIconButton extends StatelessWidget {
  _LanguageIconButton(this.languagesOpen, this.toggleLanguages);
  final bool languagesOpen;
  final VoidCallback toggleLanguages;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = languagesOpen ? const Color(0xFF152451) : Colors.transparent;
    return AnimatedContainer(
      duration: const Duration(microseconds: 175),
      color: backgroundColor,
      child: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.language,
            color: Colors.white70,
            size: 24.0,
          ),
        ),
        onTap: toggleLanguages,
      ),
    );
  }
}