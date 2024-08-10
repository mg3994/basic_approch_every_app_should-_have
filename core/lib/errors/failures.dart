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


@Equatable()
abstract class Failure {
  final String message;

  const Failure(this.message);
}
@Equatable()
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

@Equatable()
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

@Equatable()
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
