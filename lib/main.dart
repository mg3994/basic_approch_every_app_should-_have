import 'package:code_push/code_push.dart';
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
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appLightTheme(Colors.red),

        builder: (context, child) {
          if (child != null) {
            return SystemEventObserver(
              child: CodePushListener(child: child),
            );
          } else {
            return const Center(
              child: Text("App Not Started Correctly"), //TODO: this a widget
            );
          }
        },

        initialRoute: '/',
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

        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

void allowFirstFrame() {
  if (!RendererBinding.instance.sendFramesToEngine) {
    RendererBinding.instance.allowFirstFrame();
  }
}
