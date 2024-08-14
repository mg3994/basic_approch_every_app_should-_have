// core/hive/hive_initializer.dart

import 'package:dependencies/dependencies.dart' as dependency;

class HiveInitializer {
  Future<void> init() async {
    await dependency.Hive.initFlutter();
  }

  Future<dependency.Box> openAppBox(String boxName) async =>
      await dependency.Hive.openBox(boxName);
}
