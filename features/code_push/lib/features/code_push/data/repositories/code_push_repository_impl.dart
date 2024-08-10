import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../domain/repositories/code_push_repository.dart';

class CodePushRepositoryImpl implements CodePushRepository {
  final CodePushClient _client;

  CodePushRepositoryImpl(this._client);

  @override
  Future<Either<Failure, bool>> checkForUpdate() async {
    try {
      final updateAvailable = await _client.checkForUpdate();
      return Right(updateAvailable);
    } catch (e) {
      return const Left(ServerFailure('Failed to check for updates'));
    }
  }

  @override
  Future<Either<Failure, bool>> performUpdate() async {
    try {
      await _client.performUpdate();
      await Future.delayed(const Duration(seconds: 20));
      return const Right(true);
    } catch (e) {
      return const Left(ServerFailure('Failed to perform update'));
    }
  }
}

//dummy class for

abstract class CodePushClient {
  checkForUpdate();
  performUpdate();
}

class CodePushClientImpl extends CodePushClient {
  @override
  checkForUpdate() async {
    await Future.delayed(const Duration(seconds: 5));
    return true;
  }

  @override
  performUpdate() {}
}
