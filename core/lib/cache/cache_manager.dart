import 'package:core/constants/hive_keys.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/foundation.dart';

/// Cache Manager
/// A interface which is used to persist and retrieve state changes.
///
/// Simple and easy management cache, fast, and powerfull
///
/// Only support type data:
///
/// `List`, `Map`, `DateTime`, `BigInt` and `Uint8List`
///
/// **Feature**
/// * Reading cache
/// * Writing cache
/// * Deleting cache
abstract class CacheManager {
  /// Return value from a [key] Param
  ///
  dynamic read(String key);

  /// Presists key value pair
  ///
  /// In write mode only support:
  ///
  /// `List`, `Map`, `DateTime`, `BigInt` and `Uint8List`
  ///
  /// When you write, otherwise can **Error**
  Future<void>? write(String key, dynamic value);

  /// Deletes value by key
  Future<void> delete(String key);

  /// Clears all cache from storage
  Future<void> clearAll();

  Future<void> compact();
  Future<void> close();
}

/// Implementation of [CacheManager] which uses `PathProvider` and `dart.io`
/// to persist and retrieve state changes from the local device.
class CacheManagerImpl implements CacheManager {
  static CacheManagerImpl? _singleton;
  static late Box _box;

  CacheManagerImpl._();

  factory CacheManagerImpl() {
    if (_singleton == null) {
      setup();
    }
    return _singleton!;
  }

  /// Get instance Cache manager
  ///
  /// For example when instance null, then instance to be initialize
  /// When not null, return current instance
  ///
  /// When [encript] is true, all data is encript.
  /// By default [encript] is [true]
  ///
  /// Param [encryptKey] for key encript data, by default value is
  /// ['AlOp7lBkcFRdJnXFkGcBHwM9I9TJMMgr']
  ///
  /// [encryptKey] must more than 32, and <= 225

  static Future<CacheManagerImpl> setup({
    bool encrypt = true,
    String encryptKey = 'AlOp7lBkcFRdJnXFkGcBHwM9I9TJMMgr',
  }) async {
    Hive.initFlutter();

    var encryptionKey = encryptKey.codeUnits;
    _box = await Hive.openBox(
      HiveKeys.CACHE_MANAGER_BOX_KEY,
      encryptionCipher: encrypt ? HiveAesCipher(encryptionKey) : null,
    );
    _singleton = CacheManagerImpl._();

    return _singleton!;
  }

  @override
  Future<void> clearAll() async {
    if (_box.isOpen) {
      await _box.deleteFromDisk();
    }
    return;
  }

  @override
  Future<void> delete(String key) async {
    return _box.isOpen ? _box.delete(key) : null;
  }

  @override
  dynamic read(String key) {
    return _box.isOpen ? _box.get(key) : null;
  }

  @override
  Future<void>? write(String key, value) {
    return _box.isOpen ? _box.put(key, value) : null;
  }

  @override
  Future<void> close() async {
    return _box.isOpen ? _box.close() : null;
  }

  @override
  Future<void> compact() async {
    return _box.compact();
  }
}
