part of 'code_push_cubit.dart';

// @immutable
// sealed class CodePushState {}

// final class CodePushInitial extends CodePushState {}

@Equatable()
abstract class CodePushState {
  const CodePushState();
}

@Equatable()
class CodePushInitial extends CodePushState {}

@Equatable()
class CodePushLoading extends CodePushState {}

@Equatable()
class CodePushUpToDate extends CodePushState {}

@Equatable()
class CodePushNeedRestart extends CodePushState {}

@Equatable()
class CodePushError extends CodePushState {
  final String message;

  const CodePushError(this.message);
}
