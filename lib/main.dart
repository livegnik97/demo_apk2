import 'package:demo_apk/core/router/router.dart';
import 'package:demo_apk/core/theme/app_theme.dart';
import 'package:demo_apk/l10n/l10n.dart';
import 'package:demo_apk/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* cambio de idioma
//? Nota: este archivo se genera luego de compilar
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  //para poner la apk potrait
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final locale = ref.watch(localeProvider);
        final isDarkTheme = ref.watch(isDarkThemeProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Demo Apk',
          theme: AppTheme().themeLight(),
          darkTheme: AppTheme().themeDark(),
          themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          routerConfig: appRouter,

          //para el idioma
          locale: locale.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
