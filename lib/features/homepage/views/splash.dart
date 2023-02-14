import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rick_and_morty_challenge/features/auth/bloc/auth_bloc.dart';
import 'package:rick_and_morty_challenge/features/homepage/views/characters_list.dart';
import 'package:rick_and_morty_challenge/features/login/views/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AnimatedSplashScreen(
          splash: Lottie.asset(
            'assets/animations/morty-dance.json',
          ),
          nextScreen: state.when(
            authenticated: CharactersList.new,
            unauthenticated: LoginPage.new,
          ),
          backgroundColor: Colors.black,
          splashIconSize: MediaQuery.of(context).size.width * 0.5,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        );
      },
    );
  }
}
