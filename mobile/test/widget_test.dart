import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:document_assistant/l10n/app_localizations.dart';
import 'package:document_assistant/l10n/language_provider.dart';
import 'package:document_assistant/screens/landing_screen.dart';

Widget buildTestApp(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => LanguageProvider(),
    child: MaterialApp(
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

void main() {
  testWidgets('Landing screen renders app name', (tester) async {
    await tester.pumpWidget(buildTestApp(const LandingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Document Assistant'), findsOneWidget);
  });

  testWidgets('Landing screen has Get Started button', (tester) async {
    await tester.pumpWidget(buildTestApp(const LandingScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);
  });
}
