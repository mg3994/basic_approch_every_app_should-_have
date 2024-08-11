part of 'code_push_cubit.dart';

// @immutable
// sealed class CodePushState {}

// final class CodePushInitial extends CodePushState {}

@Equatable()
abstract class CodePushState {
  const CodePushState();
}

@Equatable()
final class CodePushInitial extends CodePushState {
  const CodePushInitial();
}

@Equatable()
final class CodePushLoading extends CodePushState {
  const CodePushLoading();
}

@Equatable()
final class CodePushUpToDate extends CodePushState {
  const CodePushUpToDate();
}

@Equatable()
final class CodePushNeedRestart extends CodePushState {
  const CodePushNeedRestart();
}

@Equatable()
final class CodePushError extends CodePushState {
  final String message;

  const CodePushError(this.message);
}
