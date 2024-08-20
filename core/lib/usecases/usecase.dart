import 'package:dependencies/dependencies.dart';

import '../errors/failures.dart';

abstract interface class UseCase<Type, Params> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}

@Equatable()
final class NoParams {
  const NoParams();
}
