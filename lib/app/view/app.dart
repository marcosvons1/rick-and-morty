import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/core/theme/app_theme.dart';
import 'package:rick_and_morty_challenge/features/login/views/login_page.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkThemeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoginPage(),
    );
  }
}
