import 'package:core/constants/hive_keys.dart';
import 'package:dependencies/dependencies.dart';

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
abstract interface class CacheManager {
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
      //  throw Exception('CacheManagerImpl is not initialized. Call setup() first.');
      setup(); //.then((e) => e);
    }
    // _singleton = CacheManagerImpl._();
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
    bool encrypt = false,
    String encryptKey = HiveKeys.encryptKey,
  }) async {
    Hive.initFlutter();

    var encryptionKey = encryptKey.codeUnits;
    _box = await Hive.openBox(
      HiveKeys.globalkey,
      encryptionCipher: encrypt
          ? HiveAesCipher(encryptionKey)
          : null, //bug we cant pass null here in encryptionCipher
//     ```
// version :  hive_flutter: ^2.0.0-dev
//     Error
// dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 296:3       throw_
// packages/hive/src/binary/binary_reader_impl.dart 325:11                           read
// packages/hive/src/backend/js/native/storage_backend_js.dart 86:24                 <fn>
// dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 603:19               <fn>
// dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 627:23               <fn>
// dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 525:3                _asyncStartSync
// packages/hive/src/backend/js/native/storage_backend_js.dart 79:19                 decodeValue
// dart-sdk/lib/internal/iterable.dart 425:31                                        elementAt
// dart-sdk/lib/internal/iterable.dart 354:26                                        moveNext
// dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/operations.dart 930:20  next
// dart-sdk/lib/async/future.dart 532:16                                             wait
// packages/hive/src/backend/js/native/storage_backend_js.dart 136:41                <fn>
// dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 603:19               <fn>
// dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 627:23               <fn>
// dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 525:3                _asyncStartSync
// packages/hive/src/backend/js/native/storage_backend_js.dart 136:19                <fn>
// dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/operations.dart 426:37  _checkAndCall
// dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/operations.dart 451:28  dcall
// dart-sdk/lib/html/dart2js/html_dart2js.dart 37257:58                              <fn>
//     ```
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

////////////////
///
///
// import 'package:core/constants/hive_keys.dart';
// import 'package:core/utils/extensions/log/log_x.dart';
// import 'package:dependencies/dependencies.dart' as d;

// /// Cache Manager
// /// An interface used to persist and retrieve state changes.
// ///
// /// Simple and easy management cache, fast, and powerful.
// ///
// /// Only supports data types:
// ///
// /// `List`, `Map`, `DateTime`, `BigInt`, and `Uint8List`
// ///
// /// **Features**
// /// * Reading cache
// /// * Writing cache
// /// * Deleting cache
// abstract class CacheManager {
//   /// Returns value from a [key] parameter
//   dynamic read(String key);

//   /// Persists key-value pair
//   ///
//   /// In write mode only supports:
//   ///
//   /// `List`, `Map`, `DateTime`, `BigInt`, and `Uint8List`
//   ///
//   /// Writing other types can cause an **Error**
//   Future<void>? write(String key, dynamic value);

//   /// Deletes value by key
//   Future<void> delete(String key);

//   /// Clears all cache from storage
//   Future<void> clearAll();

//   Future<void> compact();
//   Future<void> close();
// }

// /// Implementation of [CacheManager] which uses `PathProvider` and `dart.io`
// /// to persist and retrieve state changes from the local device.
// class CacheManagerImpl implements CacheManager {
//   static CacheManagerImpl? _singleton;
//   static late d.Box _box;

//   CacheManagerImpl._();

//   factory CacheManagerImpl() {
//     if (_singleton == null) {
//       print("nullable");
//       _singleton = CacheManagerImpl._();
//       var a = setup().then((e) => e.log());
//       print(a);
//     }

//     return _singleton!;
//   }

//   /// Get instance of Cache manager
//   ///
//   /// For example, when the instance is null, initialize the instance.
//   /// When not null, return the current instance.
//   ///
//   /// When [encrypt] is true, all data is encrypted.
//   /// By default, [encrypt] is [true].
//   ///
//   /// Param [encryptKey] for key encrypt data, by default value is
//   /// ['AlOp7lBkcFRdJnXFkGcBHwM9I9TJMMgr']
//   ///
//   /// [encryptKey] must be more than 32 and <= 225 characters.
//   static Future<CacheManagerImpl> setup({
//     // bool encrypt = true,
//     String encryptKey = HiveKeys.encryptKey,
//   }) async {
//     await d.Hive.initFlutter();

//     // var encryptionKey = encryptKey.codeUnits;
//     _box = await d.Hive.openBox(
//       HiveKeys.globalkey,
//       // encryptionCipher: encrypt ? HiveAesCipher(encryptionKey) : null,
//     );
//     return _singleton!;
//   }

//   @override
//   Future<void> clearAll() async {
//     if (_box.isOpen) {
//       await _box.clear();
//     }
//   }

//   @override
//   Future<void> delete(String key) async {
//     if (_box.isOpen) {
//       await _box.delete(key);
//     }
//   }

//   @override
//   dynamic read(String key) {
//     return _box.isOpen ? _box.get(key) : null;
//   }

//   @override
//   Future<void>? write(String key, dynamic value) {
//     return _box.isOpen ? _box.put(key, value) : null;
//   }

//   @override
//   Future<void> close() async {
//     if (_box.isOpen) {
//       await _box.close();
//     }
//   }

//   @override
//   Future<void> compact() async {
//     if (_box.isOpen) {
//       await _box.compact();
//     }
//   }
// }
