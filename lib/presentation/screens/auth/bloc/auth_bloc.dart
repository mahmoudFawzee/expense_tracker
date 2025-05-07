import 'dart:developer';

import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/repositories/auth_repo.dart';
import 'package:expense_tracker/data/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  final UserRepo _userRepo;

  AuthBloc(this._authRepo, this._userRepo) : super(const AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final user = await _authRepo.register(
          event.userModel,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );
        final stored = await _userRepo.storeUserLocally(user);
        if (stored) {
          log('created user: $user');
          emit(const RegisterSuccessState());
          return;
        }
        emit(const RegisterFailure(error: "user data doesn't stored"));
        final loggedOut = await _authRepo.logout();
        log('user logged out: $loggedOut');
      } catch (e) {
        log('error ${e.toString()}');
        emit(RegisterFailure(error: e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final user = await _authRepo.login(
          email: event.email,
          password: event.password,
        );
        log('logged in user: $user');
        final stored = await _userRepo.storeUserLocally(user);
        if (stored) {
          emit(const LoginSuccessState());
          return;
        }
        final loggedOut = await _authRepo.logout();
        log('user logged out: $loggedOut');
        emit(const LoginFailureState());
      } catch (e) {
        log('error ${e.toString()}');
        emit(LoginFailureState(error: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final loggedOut = await _authRepo.logout();
        if (loggedOut) {
          final deleted = await _userRepo.deleteUserLocally();
          if (deleted) {
            emit(const LogoutSuccessState());
            return;
          }
          emit(const LogoutErrorState('local data does not deleted'));
        }
      } catch (e) {
        emit(LogoutErrorState(e.toString()));
      }
    });
  }
}
