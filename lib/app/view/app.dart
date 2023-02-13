import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/injector/injector.dart';
import 'package:rick_and_morty_challenge/core/theme/app_theme.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters_list.dart';
import 'package:rick_and_morty_challenge/features/login/cubit/login_cubit.dart';
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) =>
                LoginCubit(authRepository: getIt<IAuthRepository>()),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.when(
              authenticated: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CharactersList(),
                ),
              ),
              unauthenticated: () =>
                  Navigator.of(context).pushAndRemoveUntil<void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => BlocProvider<LoginCubit>(
                    create: (context) =>
                        LoginCubit(authRepository: getIt<IAuthRepository>()),
                    child: const LoginPage(),
                  ),
                ),
                (_) => false,
              ),
            );
          },
          child: Scaffold(
            body: Center(
              child: Container(),
            ),
          ),
        ),
      ),
    );
  }
}
