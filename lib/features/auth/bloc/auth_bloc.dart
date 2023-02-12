import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const _Unauthenticated()) {
    on<_AuthStateChanges>(_onAuthStateChanged);
    on<_Logout>(_onLogout);

    add(const _AuthStateChanges());
  }

  StreamSubscription<User?> _onAuthStateChanged(
    _AuthStateChanges event,
    Emitter<AuthState> emit,
  ) {
    return FirebaseAuth.instance.authStateChanges().listen(
          (User? user) => emit(
            user == null ? const _Unauthenticated() : const _Authenticated(),
          ),
        );
  }

  FutureOr<void> _onLogout(
    _Logout event,
    Emitter<AuthState> emit,
  ) async {
    await FirebaseAuth.instance.signOut();
  }
}
