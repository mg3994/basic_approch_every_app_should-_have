import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import '../repositories/code_push_repository.dart';

class CheckForUpdateUseCase extends UseCase<bool, NoParams> {
  final CodePushRepository repository;

  CheckForUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkForUpdate();
  }
}


