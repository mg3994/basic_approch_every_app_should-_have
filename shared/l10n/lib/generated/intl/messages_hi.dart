// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'कोई सेब नहीं', one: 'एक सेब', other: '${count} सेब')}";

  static String m1(connectionType) => "कनेक्टेड: ${connectionType}";

  static String m2(gender, name) =>
      "${Intl.gender(gender, female: 'नमस्ते श्रीमती ${name}', male: 'नमस्ते श्री ${name}', other: 'नमस्ते ${name}')}";

  static String m3(name) => "हमारे एप्लिकेशन में आपका स्वागत है, ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "VPNnotAllowed":
            MessageLookupByLibrary.simpleMessage("VPN स्चीकार नहीं"),
        "apples": m0,
        "connected": m1,
        "date": MessageLookupByLibrary.simpleMessage(
            "आज की तारीख {date, date, ::yMMMMd} है"),
        "greeting": m2,
        "notConnected": MessageLookupByLibrary.simpleMessage("कनेक्शन नहीं है"),
        "price": MessageLookupByLibrary.simpleMessage(
            "मूल्य {value, currency, ::currency/INR} है"),
        "title": MessageLookupByLibrary.simpleMessage("स्थानीयकरण उदाहरण"),
        "welcome": m3
      };
}
