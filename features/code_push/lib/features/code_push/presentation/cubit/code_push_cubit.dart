import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'code_push_state.dart';

class CodePushCubit extends Cubit<CodePushState> {
  CodePushCubit() : super(CodePushInitial());
}
