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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentManager.init();
  await injectDependencies();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  // TODO(Michal): hide this somewhere

  runApp(App());
}

class App extends HookWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    scrollBehavior: const MaterialScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      },
    ),
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      Translation.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('pl'),
    ],
    routerConfig: _appRouter.config(),
    theme: ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDDE4F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      colorSchemeSeed: Colors.blue,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    ),
  );
}
