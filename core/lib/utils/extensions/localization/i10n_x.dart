import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/dependencies.dart';

extension AppLocalizationsX on BuildContext {
  /// APP_LOCALIZATIONS Translations Self Defined in shared/l10n package
  Aptr get l10n => Aptr.of(this);

  /// CupertinoLocalizations
  CupertinoLocalizations get cl10n => CupertinoLocalizations.of(this);

  /// MaterialLocalizations
  MaterialLocalizations get ml10n => MaterialLocalizations.of(this);

  /// WidgetLocalizations
  WidgetsLocalizations get wl10n => WidgetsLocalizations.of(this);
}
