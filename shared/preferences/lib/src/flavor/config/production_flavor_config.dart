part of '../config.dart';

// class ProductionConfig implements FlavorConfig {
//   const ProductionConfig();
//   @override
//   String get appName => "Antinna";

//   @override
//   String get baseUrl => 'https://example.com';

//   @override
//   final flavor = Flavor.production;
// }

class _ProductionFlavorConfig extends FlavorConfig {
  const _ProductionFlavorConfig()
      : super._internal(
            'Antinna', 'https://prod.example.com', Flavor.production);
}
