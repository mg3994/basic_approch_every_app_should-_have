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
      final bool isNeedRestart = await _client.performUpdate();

      return Right(isNeedRestart);
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
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  performUpdate() async {
    await Future.delayed(const Duration(seconds: 4));
    //download
    //should install now
    return true; //if true then it need restart else all done already
  }
}
