import 'package:code_push/code_push.dart';

import 'package:code_push/features/code_push/domain/usecases/check_for_update.dart';
import 'package:code_push/features/code_push/domain/usecases/perform_update.dart';
import 'package:component/component.dart' show SystemEventObserver;
import 'package:core/core.dart';

import 'package:dependencies/dependencies.dart' as dependency
    show
        Aptr,
        MultiBlocProvider,
        BlocProvider,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:preferences/preferences.dart';
import 'package:theme_mode/theme_mode.dart';

import 'test/test.dart';

void main() {
  // I don't want to put anything in this main method because i want to start app normally no heavy duty
  FlavorConfig config = FlavorConfig(appflavor: "staging");
  print(config.appName);
  print(config.baseUrl);
  print(config.flavor.name);
//  RendererBinding.instance.deferFirstFrame(); //TODO:?? Init state after run app
  // await dependency.Hive.initFlutter(); // Initialize Hive

  // // // Open Hive box for theme mode
  // var box = await dependency.Hive.openBox('appBox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    //  required this.box
  });
  // final dependency.Box box;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final CacheManager _cacheManager;
  late final Future<void> _hiveInitialization;

  @override
  void initState() {
    super.initState();

    _hiveInitialization = _initializeHive();
  }

  Future<void> _initializeHive() async {
    _cacheManager = await CacheManagerImpl.setup();
    //open box then put in that box also don't forget to close that
  }

  @override
  void dispose() {
    _cacheManager
        .compact(); //performance stuff file size decrease which incease performance and app runtime size say memory
    _cacheManager.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _hiveInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error initializing Hive'));
          }

          return dependency.MultiBlocProvider(
            providers: [
              dependency.BlocProvider(
                  lazy: false,
                  create: (_) => ThemeModeCubit(
                      GetThemeModeUseCase(ThemeModeRepositoryImpl(
                          ThemeModeLocalDataSourceImpl(_cacheManager))),
                      SetThemeModeUseCase(ThemeModeRepositoryImpl(
                          ThemeModeLocalDataSourceImpl(_cacheManager))))),
              // BlocProvider(lazy: false,create: (_) => ThemeSeedCubit()),
              // BlocProvider(lazy: false,create: (_) => LocaleCubit()),
              //  BlocProvider(
              //     create: (_) => ThemeCubit(),
              //   ),
              //   BlocProvider(
              //     create: (_) => FavoritesCubit(),
              //   ),
              dependency.BlocProvider(create: (context) {
                final codePushClient = const CodePushClientImpl(),
                    codePushRepository = CodePushRepositoryImpl(codePushClient),
                    checkForUpdateUseCase =
                        CheckForUpdateUseCase(codePushRepository),
                    performUpdateUseCase =
                        PerformUpdateUseCase(codePushRepository);
                return CodePushCubit(
                    checkForUpdateUseCase, performUpdateUseCase)
                  ..init();
              }),
            ],
            child: StatefulBuilder(builder: (context, setState) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: appLightTheme(Colors.red),
                darkTheme: appDarkTheme(Colors.red),
                themeMode: dependency.BlocProvider.of<ThemeModeCubit>(context,
                        listen: true)
                    .state, // we have state of themeMode as we are storing enum index of ThemeMode in sharedprefs
                // theme: appLightTheme(
                //     BlocProvider.of<ThemeSeedCubit>(context, listen: true).state.seedColor), //color as int is stored in sf
                // darkTheme: appDarkTheme(
                //     BlocProvider.of<ThemeSeedCubit>(context, listen: true).state.seedColor),
                localizationsDelegates: const [
                  dependency.Aptr.delegate,
                  ...dependency.GlobalMaterialLocalizations.delegates,
                  dependency.GlobalWidgetsLocalizations.delegate,
                
                ],
                supportedLocales: dependency.Aptr.delegate.supportedLocales,
                // localeListResolutionCallback: _localeListResolutionCallback,
                locale: dependency.Aptr.delegate.supportedLocales[1],

                builder: (context, child) {
                  if (child != null) {
                    return SystemEventObserver(
                      ///? no need to use systembrightness as system will change it automatically in ThemeMode.system. but it s here if you wish to notify remote api call
                      // onSystemBrightnessChange: (Brightness enumBrightness) {
                      //   print(enumBrightness);
                      //   dependency.BlocProvider.of<ThemeModeCubit>(context)
                      //       .ifThemeModeSystemThenChangeThemeMode(
                      //           enumBrightness);
                      // }, //enum is dark and light
                      // onSystemLocaleChange:
                      //     (List<Locale>? systemAllLocaleList, Locale preferedLocale) =>
                      //         BlocProvider.of<LocaleCubit>(context)
                      //             .ifLocaleModeSystemThenChangeLocaleToPreferedLocaleDefaultIsEnglish(
                      //                 preferedLocale, systemAllLocaleList),
                      child: CodePushListener(child: child),
                    );
                  } else {
                    return const Center(
                      child: Text(
                          "App Not Started Correctly"), //TODO: this a widget
                    );
                  }
                },

                initialRoute:
                    '/', //show walk threw onboarding and choose language screen
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case '/':
                      return MaterialPageRoute(
                          settings: settings, builder: (context) => HomePage());
                    case '/details':
                      return MaterialPageRoute(
                          settings: settings,
                          builder: (context) =>
                              // ThemeModePage()
                              DetailsPage());
                    case '/settings':
                      return MaterialPageRoute(
                          settings: settings,
                          builder: (context) => const ThemeModePage()
                          // SettingsPage()
                          );
                    default:
                      return MaterialPageRoute(
                          settings: settings,
                          builder: (context) => NotFoundPage());
                  }
                },
              );
            }),
          );
        });
  }
}

void allowFirstFrame() {
  if (!RendererBinding.instance.sendFramesToEngine) {
    RendererBinding.instance.allowFirstFrame();
  }
}

// final _setUpBlocProvider = [
//   BlocProvider(create: (context) {
//     final codePushClient = const CodePushClientImpl(),
//         codePushRepository = CodePushRepositoryImpl(codePushClient),
//         checkForUpdateUseCase = CheckForUpdateUseCase(codePushRepository),
//         performUpdateUseCase = PerformUpdateUseCase(codePushRepository);
//     return CodePushCubit(checkForUpdateUseCase, performUpdateUseCase)..init();
//   })
// ];

Locale _localeListResolutionCallback(
    List<Locale>? locales, Iterable<Locale> supportedLocales) {
  for (Locale locale in locales ?? []) {
    if (supportedLocales.contains(locale)) {
      return locale;
    }
  }
  return supportedLocales.first; // Fallback locale
}
