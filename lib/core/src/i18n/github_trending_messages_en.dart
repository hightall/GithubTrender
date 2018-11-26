import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String messageStr, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final messages = _notInlinedMessage(_notInlinedMessage);
  static _notInlinedMessage(_) => <String, Function> {
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "appName" : MessageLookupByLibrary.simpleMessage("Github Trending"),
    "repo" : MessageLookupByLibrary.simpleMessage("Repo"),
    "author": MessageLookupByLibrary.simpleMessage("Author"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "link": MessageLookupByLibrary.simpleMessage("Link"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "collapseDescription": MessageLookupByLibrary.simpleMessage("touch to collapse"),
    "expandDescription": MessageLookupByLibrary.simpleMessage("touch to expand"),
  };
}