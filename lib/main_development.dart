import 'package:auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/bootstrap.dart';
import 'package:rick_and_morty_challenge/core/injector/injector.dart'
    as injector;
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/firebase_options.dart';

import 'package:rick_and_morty_challenge/app/view/app.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    injector.initDependencies();
    return BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: injector.getIt<IAuthRepository>()),
      child: const App(),
    );
  });
}
