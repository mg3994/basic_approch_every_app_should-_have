// Flutter imports:

import 'dart:async';
import 'dart:ui' as ui;

import 'package:dependencies/dependencies.dart' as connection
    show ConnectivityResult, Connectivity;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/semantics.dart';
import 'package:core/core.dart' show AppLocalizationsX;

import '../../atom/atom.dart' show BannerHost;

final class SystemEventObserver extends StatefulWidget {
  const SystemEventObserver({
    super.key,
    required this.child,
    this.lifeCycle,
    this.onSystemBrightnessChange,
    this.onSystemLocaleChange,
    this.onMemoryPressure,
    this.onAppExitRequest,
    this.onSystemAccessibilityFeaturesChanged,
    this.onConnectivityChange,
  });
  final Widget child;

  final void Function(AppLifecycleState)? lifeCycle;
  final void Function(Brightness)? onSystemBrightnessChange;
  final void Function(List<Locale>?, Locale)? onSystemLocaleChange;
  final void Function()? onMemoryPressure;
  final Future<ui.AppExitResponse> Function()? onAppExitRequest;
  final void Function(AccessibilityFeatures)?
      onSystemAccessibilityFeaturesChanged;
  final void Function(connection.ConnectivityResult)? onConnectivityChange;

  @override
  State<SystemEventObserver> createState() => _SystemEventObserverState();
}

final class _SystemEventObserverState extends State<SystemEventObserver>
    with WidgetsBindingObserver {
  late final _connectivity = _connectivityStream();
  late final StreamSubscription<connection.ConnectivityResult>
      _connectivitySubscription;
  Stream<connection.ConnectivityResult> _connectivityStream() async* {
    try {
      final connectivity = connection.Connectivity();
      final result = await connectivity.checkConnectivity();
      yield result.firstOrNull ??
          connection.ConnectivityResult.none; //single distinct result only
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
    _connectivitySubscription = _connectivityStream().listen((result) {
      if (widget.onConnectivityChange != null) {
        widget.onConnectivityChange!(result);
      }
      // (error) {
      //   debugPrint('Connectivity error: $error');
      // };
      // () {
      //   debugPrint('Connectivity stream closed');
      // };
      // true;
    });
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
              return const CircularProgressIndicator(); //TODO: load splash here
            } else {
              final result = streamSnapshot.requireData;
              return BannerHost(
                  hideBanner: result != connection.ConnectivityResult.none,
                  banner: Material(
                    color: switch (result) {
                      connection.ConnectivityResult.none => Colors.red,
                      _ => Colors.green,
                    },
                    // (result != connection.ConnectivityResult.none)
                    //     ? Colors.green
                    //     : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 12.0,
                      ),
                      child: Text(
                        switch (result) {
                          connection.ConnectivityResult.none =>
                            context.l10n.notConnected,
                          _ => context.l10n.connected(result.name.toString())
                        },
                        // (result != connection.ConnectivityResult.none)
                        //     ? context.l10n.connected(result.name.toString())
                        //     : context.l10n.notConnected,
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
    _connectivitySubscription.cancel(); // Dispose the connectivity subscription
    super.dispose();
  }
}
