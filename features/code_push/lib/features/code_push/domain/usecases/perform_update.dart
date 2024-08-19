import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import '../repositories/code_push_repository.dart';

class PerformUpdateUseCase implements UseCase<void, NoParams> {
  final CodePushRepository repository;

  const PerformUpdateUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.performUpdate();
  }
}
