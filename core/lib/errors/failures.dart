// import 'package:equatable/equatable.dart';

// sealed class Failure extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class ServerFailure extends Failure {}

// class CacheFailure extends Failure {}

// class EmptyFailure extends Failure {}

// class CredentialFailure extends Failure {}

// class DuplicateEmailFailure extends Failure {}

// class PasswordNotMatchFailure extends Failure {}

// class InvalidEmailFailure extends Failure {}

// class InvalidPasswordFailure extends Failure {}

// import 'package:equatable/equatable.dart';

// abstract class Failure extends Equatable {
//   Failure([List properties = const <dynamic>[]]) : super(properties);
// }

// class ServerFailure extends Failure {}

// class CacheFailure extends Failure {}

// class NoConnectionFailure extends Failure {}

// abstract class Failure {
//   const Failure() : super();
// }

// class ServerFailure extends Failure {}

// class CacheFailure extends Failure {}

// class NoConnectionFailure extends Failure {}

import 'package:dependencies/dependencies.dart';

@pragma('antinna:keep-to-string-in-subtypes by remind')
// @Equatable(
//     stringify:
//         true) // TODO: // stringify for above use case //comment this here but apply this in all subtypes
abstract interface class Failure {
  factory Failure([var message]) => _Failure(message);
}

/// Default implementation of [Failure] which carries a message.
@Equatable(stringify: true) // stringify for above use case
class _Failure implements Failure {
  final dynamic message;

  const _Failure([this.message]);
}

@Equatable(stringify: true) // stringify for above use case
class ServerFailure implements Failure {
  /// A message describing the format error.
  final String message;
  const ServerFailure([this.message = ""]);
}

@Equatable(stringify: true) // stringify for above use case
class CacheFailure implements Failure {
  /// A message describing the format error.
  final String message;
  const CacheFailure([this.message = ""]);
}

@Equatable(stringify: true) // stringify for above use case
class NetworkFailure implements Failure {
  /// A message describing the format error.
  final String message;
  const NetworkFailure([this.message = ""]);
}
