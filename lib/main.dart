import 'package:code_push/code_push.dart';
import 'package:code_push/features/code_push/domain/usecases/check_for_update.dart';
import 'package:code_push/features/code_push/domain/usecases/perform_update.dart';
import 'package:component/component.dart' show SystemEventObserver;
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import 'test/test.dart';

void main() {
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
        BlocProvider(
            create: (context) => CodePushCubit(
                  CheckForUpdateUseCase(
                      CodePushRepositoryImpl(CodePushClientImpl())),
                  PerformUpdateUseCase(
                      CodePushRepositoryImpl(CodePushClientImpl())),
                )..init()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',

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
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
