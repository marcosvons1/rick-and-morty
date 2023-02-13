import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const _Unauthenticated()) {
    on<_AuthStateChanges>(_onAuthStateChanged);
    on<_Logout>(_onLogout);

    add(const _AuthStateChanges());
  }

  final IAuthRepository _authRepository;

  void _onAuthStateChanged(
    _AuthStateChanges event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.user.listen((Option<User> user) {
      user.fold(
        () => emit(const _Unauthenticated()),
        (_) => emit(const _Authenticated()),
      );
    });
  }

  FutureOr<void> _onLogout(
    _Logout event,
    Emitter<AuthState> emit,
  ) async {
    await FirebaseAuth.instance.signOut();
  }
}
