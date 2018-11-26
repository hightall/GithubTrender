import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:github_trending/core/core.dart';

class MessageProvider {
  MessageProvider(this.messages);
  final Messages messages;

  static Future<MessageProvider> load(Locale locale) {
    final String name =
      locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return MessageProvider(Messages());
    });
  }

  static Messages of(BuildContext context) {
    return Localizations.of<MessageProvider>(context, MessageProvider).messages;
  }
}

class GithubTrendingLocalizationsDelegate extends LocalizationsDelegate<MessageProvider> {
  const GithubTrendingLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<MessageProvider> load(Locale locale) => MessageProvider.load(locale);

  @override
  bool shouldReload(GithubTrendingLocalizationsDelegate old) => false;
}