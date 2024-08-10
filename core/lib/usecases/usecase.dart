import 'package:dependencies/dependencies.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
@Equatable()
class NoParams {}
