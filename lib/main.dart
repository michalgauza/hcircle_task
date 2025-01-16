import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/environment_manager.dart';
import 'utils/injectable/injectable.dart';
import 'utils/ui/router/app_router.dart';
import 'utils/ui/translations/generated/l10n.dart';

// I was not able to test this app on IOS because I don't have a Mac :(.
// In Poland it's most popular that companies provide computer for their employees, even on B2B.
// I need to buy a Mac ASAP :D
// But I assure you that I know how to write app that works on IOS.

// TODO(Michal): TODO list
// 1. tests
// 2. remove unwanted code
// 3. check todos

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvironmentManager.init();
  await injectDependencies();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(App());
}

class App extends HookWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        localizationsDelegates: const [
          Translation.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
        routerConfig: _appRouter.config(),
        theme: ThemeData(
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFFDDE4F0),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          // ),
          // colorSchemeSeed: Colors.blue,
          // scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          useMaterial3: true,
        ),
      );
}
