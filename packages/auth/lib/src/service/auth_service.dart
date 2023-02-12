import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<Either<Failure, void>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();

  StreamSubscription<User?> get onAuthStateChanged;
}

class AuthService implements IAuthService {
  AuthService({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<Either<Failure, void>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  // TODO: implement onAuthStateChanged
  StreamSubscription<User?> get onAuthStateChanged =>
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          return;
        } else {
          return user;
        }
      });
}
