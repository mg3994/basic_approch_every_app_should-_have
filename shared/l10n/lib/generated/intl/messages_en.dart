// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'No apples', one: 'One apple', other: '${count} apples')}";

  static String m1(connectionType) => "Connected: ${connectionType}";

  static String m2(gender, name) =>
      "${Intl.gender(gender, female: 'Hello Ms. ${name}', male: 'Hello Mr. ${name}', other: 'Hello ${name}')}";

  static String m3(name) => "Welcome to our application, ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "VPNnotAllowed":
            MessageLookupByLibrary.simpleMessage("VPN Not Allowed"),
        "apples": m0,
        "connected": m1,
        "date": MessageLookupByLibrary.simpleMessage(
            "Today\'s date is {date, date, ::yMMMMd}"),
        "greeting": m2,
        "notConnected": MessageLookupByLibrary.simpleMessage("Not Connected"),
        "price": MessageLookupByLibrary.simpleMessage(
            "The price is {value, currency, ::currency/USD}"),
        "title": MessageLookupByLibrary.simpleMessage("Localization Example"),
        "welcome": m3
      };
}
