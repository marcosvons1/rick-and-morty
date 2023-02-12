import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_challenge/app/app.dart';
import 'package:rick_and_morty_challenge/bootstrap.dart';
import 'package:rick_and_morty_challenge/firebase_options.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return const App();
  });
}
