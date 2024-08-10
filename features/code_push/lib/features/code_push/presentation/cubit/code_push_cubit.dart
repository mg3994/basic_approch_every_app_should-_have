// import 'package:bloc/bloc.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dependencies/dependencies.dart';
import 'package:meta/meta.dart';

// part 'code_push_state.dart';

// class CodePushCubit extends Cubit<CodePushState> {
//   CodePushCubit() : super(CodePushInitial());
// }

////////
///
///
///

import '../../domain/usecases/check_for_update.dart';
import '../../domain/usecases/perform_update.dart';

part 'code_push_state.dart';

// class CodePushCubit extends Cubit<CodePushState> {
//   final CheckForUpdateUseCase checkForUpdateUseCase;
//   final PerformUpdateUseCase performUpdateUseCase;

//   CodePushCubit({
//     required this.checkForUpdateUseCase,
//     required this.performUpdateUseCase,
//   }) : super(CodePushInitial());

//   void init() async {
//     emit(CodePushLoading());
//     final updateResult = await checkForUpdateUseCase(NoParams());
//     updateResult.fold(
//       (failure) => emit(CodePushError(failure.message)),
//       (updateAvailable) {
//         if (updateAvailable) {
//           _performUpdate();
//         } else {
//           emit(CodePushUpToDate());
//         }
//       },
//     );
//   }

//   void _performUpdate() async {
//     final result = await performUpdateUseCase(NoParams());
//     result.fold(
//       (failure) => emit(CodePushError(failure.message)),
//       (_) => emit(CodePushUpdated()),
//     );
//   }
// }

class CodePushCubit extends Cubit<CodePushState> {
  final CheckForUpdateUseCase checkForUpdateUseCase;
  final PerformUpdateUseCase performUpdateUseCase;

  CodePushCubit(
    this.checkForUpdateUseCase,
    this.performUpdateUseCase,
  ) : super(CodePushInitial());

  Future<void> init() async {
    emit(CodePushLoading());
    final result = await checkForUpdateUseCase(NoParams());
    result.fold(
      (failure) => emit(CodePushError(failure.message)),
      (updateAvailable) => updateAvailable
          ? updateApp()
         
          : emit(CodePushUpToDate()),
    );
  }

  Future<void> updateApp() async {
    // emit(CodePushLoading());
    final result = await performUpdateUseCase(NoParams());
    result.fold(
      (failure) => emit(CodePushError(failure.message)),
      (isNeedRestart) => emit(CodePushNeedRestart()),
    );
  }
}
