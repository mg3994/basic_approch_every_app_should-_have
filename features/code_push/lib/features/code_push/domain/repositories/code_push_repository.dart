import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

abstract interface class CodePushRepository {
  Future<Either<Failure, bool>> checkForUpdate();
  Future<Either<Failure, bool>> performUpdate();
}
