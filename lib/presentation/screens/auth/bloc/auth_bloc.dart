import 'dart:developer';

import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/exceptions/backend_validation_exceptions.dart';
import 'package:expense_tracker/data/models/user/logged_in_user.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/repositories/auth_repo.dart';
import 'package:expense_tracker/data/repositories/tokens_repo.dart';
import 'package:expense_tracker/data/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  final UserDataRepo _userRepo;
  final TokensRepo _tokensRepo;
  Future<bool> _storeUserData(dynamic result) async {
    try {
      if (result is LoggedInUser) {
        final tokenStored =
            await _tokensRepo.storeAccessToken(result.accessToken);
        if (tokenStored) {
          return await _userRepo.storeUserLocally(result.user);
        }
      }

      log('type is wrong');
      return false;
    } catch (e) {
      log('some exception: ${e.toString()}');
      return false;
    }
  }

  AuthBloc(this._authRepo, this._userRepo, this._tokensRepo)
      : super(const AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final result = await _authRepo.register(
          event.userModel,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        if (result is UserModel) {
          final loggedInResult = await _authRepo.login(
            email: result.email,
            password: event.password,
          );

          final dataStored = await _storeUserData(
            loggedInResult,
          );
          if (dataStored) {
            emit(const RegisterSuccessState());
            return;
          }
          //?not stored
          //await _authRepo.logout('access_token');
          emit(const RegisterFailure(error: 'error when storing data'));
          return;
        }
        if (result is ValidationExceptions) {
          final errors = result.errors;
          //?now we get errors
          emit(RegisterFailure(
            //?we got the errors as list we just need the first error
            phoneNumberError: errors?[JsonKeys.phoneNumber]?.first,
            emailError: errors?[JsonKeys.email]?.first,
            firstNameError: errors?[JsonKeys.firstName]?.first,
            lastNameError: errors?[JsonKeys.lastName]?.first,
            passwordError: errors?[JsonKeys.password]?.first,
            confirmPasswordError: errors?[JsonKeys.password]?.first,
          ));
          return;
        }
        emit(RegisterFailure(error: result[JsonKeys.message]));
      } catch (e) {
        log('error ${e.toString()}');
        emit(RegisterFailure(error: e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final result = await _authRepo.login(
          email: event.email,
          password: event.password,
        );
        log('logged in user: $result');
        final stored = await _storeUserData(result);
        if (stored) {
          emit(const LoginSuccessState());
          return;
        }
        if (result is Map<String, List<String>>) {
          emit(LoginFailureState(
            emailError: result[JsonKeys.email]?.first,
            passwordError: result[JsonKeys.email]?.first,
          ));
          return;
        }
        emit(const LoginFailureState(error: "UnExpected Error Happened"));
      } catch (e) {
        log('error ${e.toString()}');
        emit(LoginFailureState(error: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        final accessToken = await _tokensRepo.fetchAccessToken();
        final loggedOut = await _authRepo.logout(accessToken!);
        if (loggedOut) {
          final deletedToken = await _tokensRepo.deleteAccessToken();
          final deleted = await _userRepo.deleteUserLocally();
          if (deleted && deletedToken) {
            emit(const LogoutSuccessState());
            return;
          }
          emit(const LogoutErrorState('some error happened'));
        }
      } catch (e) {
        emit(LogoutErrorState(e.toString()));
      }
    });
  }
}
