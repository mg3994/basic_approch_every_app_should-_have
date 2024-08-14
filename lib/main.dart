import 'package:code_push/code_push.dart';
import 'package:code_push/features/ThemeMode/presentation/cubit/theme_mode_cubit.dart';
import 'package:code_push/features/code_push/domain/usecases/check_for_update.dart';
import 'package:code_push/features/code_push/domain/usecases/perform_update.dart';
import 'package:component/component.dart' show SystemEventObserver;

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:preferences/preferences.dart';

import 'test/test.dart';

void main() {
  FlavorConfig config = FlavorConfig(appflavor: "staging");
  print(config.appName);
  print(config.baseUrl);
  print(config.flavor.name);
//  RendererBinding.instance.deferFirstFrame(); //TODO:?? Init state after run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (_) => ThemeModeCubit()),
        // BlocProvider(lazy: false,create: (_) => ThemeSeedCubit()),
        // BlocProvider(lazy: false,create: (_) => LocaleCubit()),
        //  BlocProvider(
        //     create: (_) => ThemeCubit(),
        //   ),
        //   BlocProvider(
        //     create: (_) => FavoritesCubit(),
        //   ),
        BlocProvider(create: (context) {
          final codePushClient = const CodePushClientImpl(),
              codePushRepository = CodePushRepositoryImpl(codePushClient),
              checkForUpdateUseCase = CheckForUpdateUseCase(codePushRepository),
              performUpdateUseCase = PerformUpdateUseCase(codePushRepository);
          return CodePushCubit(checkForUpdateUseCase, performUpdateUseCase)
            ..init();
        }),
      ],
      child: StatefulBuilder(builder: (context, setState) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: appLightTheme(Colors.red),
          darkTheme: appDarkTheme(Colors.red),
          themeMode: BlocProvider.of<ThemeModeCubit>(context, listen: true)
              .state, // we have state of themeMode as we are storing enum index of ThemeMode in sharedprefs
          // theme: appLightTheme(
          //     BlocProvider.of<ThemeSeedCubit>(context, listen: true).state.seedColor), //color as int is stored in sf
          // darkTheme: appDarkTheme(
          //     BlocProvider.of<ThemeSeedCubit>(context, listen: true).state.seedColor),

          builder: (context, child) {
            if (child != null) {
              return SystemEventObserver(
                onSystemBrightnessChange: (Brightness enumBrightness) {
                  print(enumBrightness);
                  BlocProvider.of<ThemeModeCubit>(context)
                      .ifThemeModeSystemThenChangeThemeMode(enumBrightness);
                }, //enum is dark and light
                // onSystemLocaleChange:
                //     (List<Locale>? systemAllLocaleList, Locale preferedLocale) =>
                //         BlocProvider.of<LocaleCubit>(context)
                //             .ifLocaleModeSystemThenChangeLocaleToPreferedLocaleDefaultIsEnglish(
                //                 preferedLocale, systemAllLocaleList),
                child: CodePushListener(child: child),
              );
            } else {
              return const Center(
                child: Text("App Not Started Correctly"), //TODO: this a widget
              );
            }
          },

          initialRoute:
              '/', //show walk threw onboarding and choose language screen
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => HomePage());
              case '/details':
                return MaterialPageRoute(builder: (context) => DetailsPage());
              case '/settings':
                return MaterialPageRoute(builder: (context) => SettingsPage());
              default:
                return MaterialPageRoute(builder: (context) => NotFoundPage());
            }
          },
        );
      }),
    );
  }
  // CodePushCubit codePushMethod(context) {
  //     final codePushClient = const CodePushClientImpl(),
  //         codePushRepository = CodePushRepositoryImpl(codePushClient),
  //         checkForUpdateUseCase = CheckForUpdateUseCase(codePushRepository),
  //         performUpdateUseCase = PerformUpdateUseCase(codePushRepository);
  //     return CodePushCubit(checkForUpdateUseCase, performUpdateUseCase)
  //       ..init();
  //   }
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