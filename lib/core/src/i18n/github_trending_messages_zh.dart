import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent(String messageStr, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'zh';

  final messages = _notInlinedMessage(_notInlinedMessage);
  static _notInlinedMessage(_) => <String, Function> {
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "appName" : MessageLookupByLibrary.simpleMessage("Github代码趋势"),
    "repo" : MessageLookupByLibrary.simpleMessage("代码仓库"),
    "author": MessageLookupByLibrary.simpleMessage("作者"),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "link": MessageLookupByLibrary.simpleMessage("链接"),
    "description": MessageLookupByLibrary.simpleMessage("描述"),
    "collapseDescription": MessageLookupByLibrary.simpleMessage("关闭更多"),
    "expandDescription": MessageLookupByLibrary.simpleMessage("显示更多"),
  };
}
