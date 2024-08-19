import 'package:dependencies/dependencies.dart' show Equatable
;

@Equatable(stringify: true) // stringify for above use case
class ServerException implements Exception {}
@Equatable(stringify: true) // stringify for above use case
class CacheException implements Exception {}
@Equatable(stringify: true) // stringify for above use case
class AuthException implements Exception {}
@Equatable(stringify: true) // stringify for above use case
class EmptyException implements Exception {}
@Equatable(stringify: true) // stringify for above use case
class DuplicateEmailException implements Exception {}
