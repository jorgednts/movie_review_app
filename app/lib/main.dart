import 'package:app/firebase_options.dart';
import 'package:app/src/presentation/di/dependencies.dart';
import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:app/src/presentation/utils/custom_theme_notifier.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(providers: Dependencies.providers, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<CustomThemeNotifier>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: CustomScaffoldMessenger.scaffoldMessengerKey,
      onGenerateTitle: (context) => AppIntl.of(context).app_name,
      localizationsDelegates: [
        AppIntl.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: themeNotifier.themeMode,
      theme: CustomTheme.fromContext(context).light(),
      darkTheme: CustomTheme.fromContext(context).dark(),
      routerConfig: AppRouter.router,
      supportedLocales: AppIntl.delegate.supportedLocales,
    );
  }
}
