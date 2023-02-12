import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';

import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(ImageConstants.rickAndMortyLogo),
            Container(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text(l10n.login),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
