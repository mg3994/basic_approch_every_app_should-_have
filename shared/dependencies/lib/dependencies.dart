/// Support for doing something awesome.
///
/// More dartdocs go here.
library dependencies;

import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

// ?# dependencies:
export 'package:intl/intl.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:macros/macros.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:freezed_annotation/freezed_annotation.dart';
export 'package:equatable_macro/equatable_macro.dart';
export 'package:dartz/dartz.dart';
export 'package:connectivity_plus/connectivity_plus.dart';

// export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:path_provider/path_provider.dart';
export 'package:l10n/l10n.dart';

// ?# dev_dependencies:

// export 'package:bloc_test/bloc_test.dart';
// export 'package:build_runner/build_runner.dart';
// export 'package:freezed/src/freezed_generator.dart';
// // export 'package:freezed/builder.dart';
// export 'package:json_serializable/json_serializable.dart';

// TODO: Export any libraries intended for clients of this package.
// ?# self_dependencies:
export 'src/dependencies_base.dart';

extension AppLocalizationsX on BuildContext {
  String get title => Aptr.of(this).title;

  /// Retrieves the localized connected string from AppLocalizationsX.
  String connected(Object connectionType) =>
      Aptr.of(this).connected(connectionType);

  /// Retrieves the localized notConnected string from AppLocalizationsX.
  String get notConnected => Aptr.of(this).notConnected;
  Aptr get aptr => Aptr.of(this);
}
