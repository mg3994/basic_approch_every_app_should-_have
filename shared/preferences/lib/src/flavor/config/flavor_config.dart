part of '../config.dart';



abstract interface class FlavorConfig {
  const FlavorConfig._internal(this.appName, this.baseUrl, this.flavor);

  final String appName;
  final String baseUrl;
  final Flavor flavor;

  factory FlavorConfig({String? appflavor = appFlavor}) {
    switch (appflavor) {
      case 'development':
        return const _DevelopmentFlavorConfig();
      case "staging":
        return const _StagingFlavorConfig();
      case "production":
      default:
        return const _ProductionFlavorConfig();
    }
  }
}

enum Flavor {
  // set them in alphabatical order with full name
  development,
  production,
  staging
}
