import 'package:dartz/dartz.dart';
import 'package:dio/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
  Stream<Option<User>> get user;
}

class AuthRepository implements IAuthRepository {
  @override
  Stream<Option<User>> get user =>
      FirebaseAuth.instance.authStateChanges().map((User? user) {
        if (user != null) {
          return some(user);
        } else {
          return none();
        }
      });

  @override
  Future<Either<Failure, Unit>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(unit);
    } catch (e) {
      return const Left(Failure());
    }
  }
}
