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

///   if (state is CodePushError) {
///  if (state.failure is CacheFailure) {
///     final CacheFailure c = state.failure as CacheFailure;
///     c.message;
///   }
/// }
/// or
///     if (state is CodePushError) {
///   switch (state.failure ) {
///     case is CacheFailure:

///       break;
///     default:
///   }

/// }
final class CodePushError extends CodePushState {
  final Failure
      failure; // falure is here because i want to listen and as per message if there build Localized Translted error way/system Text output

  const CodePushError(this.failure);
}
