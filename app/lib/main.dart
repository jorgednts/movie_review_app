import 'package:app/src/presentation/di/dependencies.dart';
import 'package:app/src/presentation/navigation/app_router.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:internationalization/internationalization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  debugPrint('API KEY = ${dotenv.get('TMDB_API_KEY')}');

  runApp(
    MultiProvider(providers: Dependencies.providers, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppIntl.of(context).app_name,
      localizationsDelegates: [
        AppIntl.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.from(
        colorScheme: AppTheme.lightColorScheme,
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
      supportedLocales: AppIntl.delegate.supportedLocales,
    );
  }
}
