import 'package:dependencies/dependencies.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}

@Equatable()
class NoParams {
  const NoParams();
}
