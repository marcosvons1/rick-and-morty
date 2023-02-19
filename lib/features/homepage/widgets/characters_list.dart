import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/bloc/characters_bloc.dart';
import 'package:rick_and_morty_challenge/features/login/views/login.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (characters, page, hasReachedMax) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        return index >= characters.length
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListTile(
                                title: Text(characters[index].name),
                              );
                      },
                    ),
                  );
                },
                error: (failure) => Center(
                  child: Text(failure.toString()),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthEvent.logout()),
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
