import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_challenge/core/validators/email.dart';
import 'package:rick_and_morty_challenge/core/validators/password.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> loginSubmission() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final email = state.email;
      final password = state.password;

      final successOrFailure =
          await fakeLogin(username: email.value, password: password.value);

      successOrFailure.fold(
        (failure) =>
            emit(state.copyWith(status: FormzStatus.submissionFailure)),
        (success) =>
            emit(state.copyWith(status: FormzStatus.submissionSuccess)),
      );
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<Either<LoginFailure, void>> fakeLogin({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (username == 'admin123' && password == 'admin123') {
      return const Right(null);
    } else {
      return Left(LoginFailure());
    }
  }
}

class LoginFailure {}
