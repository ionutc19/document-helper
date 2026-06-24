import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'l10n/app_localizations.dart';
import 'l10n/language_provider.dart';
import 'services/service_locator.dart';
import 'screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  ServiceLocator.instance.initialize();

  final languageProvider = LanguageProvider();
  await languageProvider.init();

  runApp(
    ChangeNotifierProvider.value(
      value: languageProvider,
      child: const DocumentAssistantApp(),
    ),
  );
}

class DocumentAssistantApp extends StatelessWidget {
  const DocumentAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      title: 'Document Assistant',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      locale: langProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LandingScreen(),
    );
  }
}
