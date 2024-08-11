part of '../config.dart';

// class DevelopmentConfig implements FlavorConfig {
//   const DevelopmentConfig();
//   @override
//   String get appName => "[DEV] Antinna";

//   @override
//   String get baseUrl => 'https://dev.example.com';

//   @override
//   final flavor = Flavor.development;
// }

class _DevelopmentFlavorConfig extends FlavorConfig {
  const _DevelopmentFlavorConfig()
      : super._internal(
            '[DEV] Antinna', 'https://dev.example.com', Flavor.development);
}
