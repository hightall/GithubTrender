import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';
import 'package:github_trending/core/src/i18n/github_trending_messages_en.dart' deferred as messages_en;
import 'package:github_trending/core/src/i18n/github_trending_messages_zh.dart' deferred as messages_zh;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'en': () => messages_en.loadLibrary(),
  'zh': () => messages_zh.loadLibrary(),
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case 'en':
      return messages_en.messages;
    case 'zh':
      return messages_zh.messages;
    default:
      return null;
  }
}

Future<bool> initializeMessages(String localName) async {
  var availableLocale = Intl.verifiedLocale(localName, (locale) => _deferredLibraries[locale] != null, onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessageFor);
  return new Future.value(true);
}

bool _messageExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessageFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messageExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}