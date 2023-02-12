import 'package:auth/src/service/auth_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/lib.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
}

class AuthRepository implements IAuthRepository {
  AuthRepository({required IAuthService authService})
      : _authService = authService;
  final IAuthService _authService;

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
}
