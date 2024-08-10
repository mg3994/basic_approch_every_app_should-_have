// Flutter imports:

import 'dart:ui' as ui;

import 'package:dependencies/dependencies.dart' as connection;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/semantics.dart';

import 'package:antinna/component/lib/src/atom/banner_host.dart';

class SystemEventObserver extends StatefulWidget {
  const SystemEventObserver({
    super.key,
    required this.child,
    this.lifeCycle,
    this.onSystemBrightnessChange,
    this.onSystemLocaleChange,
    this.onMemoryPressure,
    this.onAppExitRequest,
    this.onSystemAccessibilityFeaturesChanged,
  });
  final Widget child;
  final Function(AppLifecycleState)? lifeCycle;
  final Function(Brightness)? onSystemBrightnessChange;
  final Function(List<Locale>?, Locale)? onSystemLocaleChange;
  final Function()? onMemoryPressure;
  final Future<ui.AppExitResponse> Function()? onAppExitRequest;
  final Function(AccessibilityFeatures)? onSystemAccessibilityFeaturesChanged;

  @override
  State<SystemEventObserver> createState() => _SystemEventObserverState();
}

class _SystemEventObserverState extends State<SystemEventObserver>
    with WidgetsBindingObserver {
  late final _connectivity = _connectivityStream();
  Stream<connection.ConnectivityResult> _connectivityStream() async* {
    try {
      final connectivity = connection.Connectivity();
      final result = await connectivity.checkConnectivity();
      yield result.first; //single distinct result only
      yield* connectivity.onConnectivityChanged.expand(
        (results) => results,
      ); // Flatten the stream
    } catch (e) {
      // Handle the error appropriately
      debugPrint('Connectivity error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkSemantics();
  }

  void _checkSemantics() {
    if (ui.PlatformDispatcher.instance.semanticsEnabled) {
      SemanticsBinding.instance.ensureSemantics();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (widget.lifeCycle != null) {
      widget.lifeCycle!(state);
    }
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    if (widget.onSystemBrightnessChange != null) {
      widget.onSystemBrightnessChange!(
          SchedulerBinding.instance.platformDispatcher.platformBrightness);
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (widget.onSystemLocaleChange != null &&
        locales != null &&
        locales.isNotEmpty) {
      final systemPreferedLocale = locales.first;
      // final systemPreferredLocale =
      //     SchedulerBinding.instance.platformDispatcher.locale;
      widget.onSystemLocaleChange!(
        locales,
        systemPreferedLocale,
      );
    }
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    if (widget.onMemoryPressure != null) {
      widget.onMemoryPressure!();
    }
  }

  @override
  Future<ui.AppExitResponse> didRequestAppExit() async {
    if (widget.onAppExitRequest != null) {
      return await widget.onAppExitRequest!();
    }
    return super.didRequestAppExit();
  }

  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    if (widget.onSystemAccessibilityFeaturesChanged != null) {
      final accessibilityFeatures =
          ui.PlatformDispatcher.instance.accessibilityFeatures;
      widget.onSystemAccessibilityFeaturesChanged!(accessibilityFeatures);
    }
  }

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<connection.ConnectivityResult>(
          stream: _connectivity,
          builder: (
            BuildContext context,
            AsyncSnapshot<connection.ConnectivityResult> streamSnapshot,
          ) {
            if (streamSnapshot.connectionState != ConnectionState.active) {
              return const CircularProgressIndicator(); //TODO load splash here
            } else {
              final result = streamSnapshot.requireData;
              return BannerHost(
                  hideBanner: result != connection.ConnectivityResult.none,
                  banner: Material(
                    color: (result != connection.ConnectivityResult.none)
                        ? Colors.green
                        : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 12.0,
                      ),
                      child: Text(
                        (result != connection.ConnectivityResult.none)
                            ? "Connected"
                            : 'No Internet',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  child: widget.child);
            }
          });

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
