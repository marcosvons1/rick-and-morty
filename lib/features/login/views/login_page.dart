import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters_list.dart';
import 'package:rick_and_morty_challenge/features/login/cubit/login_cubit.dart';
import 'package:rick_and_morty_challenge/features/sign_up/views/sign_up.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: () => Navigator.of(context).push<void>(
            CharactersList.route(),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(ImageConstants.rickAndMortyLogo),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.email,
                          ),
                          onChanged: (value) =>
                              context.read<LoginCubit>().emailChanged(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.password,
                          ),
                          obscureText: true,
                          onChanged: (value) =>
                              context.read<LoginCubit>().passwordChanged(value),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF5CAD4A),
                          ),
                        ),
                        child: Text(l10n.login),
                        onPressed: () {
                          context.read<LoginCubit>().loginSubmission();
                          context.read<AuthBloc>().state.when(
                                authenticated: () =>
                                    Navigator.of(context).push<void>(
                                  CharactersList.route(),
                                ),
                                unauthenticated: () {},
                              );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push<void>(
                                SignUpPage.route(),
                              ),
                              child: const Text(
                                'Sign up!',
                                style: TextStyle(
                                  color: Color(0xFFa6eee6),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
