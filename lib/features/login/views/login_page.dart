import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/core/constants/string_constants.dart';
import 'package:rick_and_morty_challenge/features/login/cubit/login_cubit.dart';

import 'package:rick_and_morty_challenge/l10n/l10n.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
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
                          errorText: state.email.error?.when(
                            empty: () => l10n.emptyEmail,
                            invalid: () => l10n.invalidEmail,
                          ),
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
                          errorText: state.password.error?.when(
                            empty: () => l10n.emptyPassword,
                            invalid: () => l10n.invalidPassword,
                          ),
                        ),
                        onChanged: (value) =>
                            context.read<LoginCubit>().passwordChanged(value),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(l10n.login),
                      onPressed: () {},
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
