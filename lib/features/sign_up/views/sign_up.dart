import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters_list.dart';
import 'package:rick_and_morty_challenge/features/login/views/login_page.dart';
import 'package:rick_and_morty_challenge/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: () =>
              Navigator.of(context).push<void>(CharactersList.route()),
        );
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(ImageConstants.rickAndMortyLogo),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.email,
                            errorText: state.email.error?.when(
                              empty: () => l10n.emptyEmail,
                              invalid: () => l10n.invalidEmail,
                            ),
                          ),
                          onChanged: (value) =>
                              context.read<SignUpCubit>().emailChanged(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            errorText: state.password.error?.when(
                              empty: () => l10n.emptyPassword,
                              invalid: () => l10n.invalidPassword,
                            ),
                          ),
                          onChanged: (value) => context
                              .read<SignUpCubit>()
                              .passwordChanged(value),
                        ),
                      ),
                      GestureDetector(
                        child: const Text('Login'),
                        onTap: () {
                          Navigator.of(context).push<void>(LoginPage.route());
                        },
                      ),
                      ElevatedButton(
                        child: const Text('SignUp'),
                        onPressed: () {
                          context.read<SignUpCubit>().signUpSubmission();
                        },
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
