import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/models/user/exceptions/auth_exception.dart';
import 'package:expense_tracker/data/models/user/logged_in_user.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/repositories/auth_repo.dart';
import 'package:expense_tracker/data/repositories/tokens_repo.dart';
import 'package:expense_tracker/data/repositories/user/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  final UserDataRepo _userRepo;
  final TokensRepo _tokensRepo;
  Future<bool> _storeUserData(LoggedInUser result) async {
    try {
      final tokenStored =
          await _tokensRepo.storeAccessToken(result.accessToken);

      if (tokenStored) {
        final user = UserModel(
          firstName: result.user.firstName,
          lastName: result.user.lastName,
          phoneNumber: result.user.phoneNumber,
          email: result.user.email,
        );
        final userStored = await _userRepo.storeUser(user);
        return userStored != null;
      }

      return false;
    } catch (e) {
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
      } on AuthException catch (e) {
        final errors = e.errors;
        //?now we get errors
        emit(RegisterFailure(
          //?we got the errors as list we just need the first error
          phoneNumberError: errors?[JsonKeys.phoneNumber]?.first,
          emailError: errors?[JsonKeys.email]?.first,
          firstNameError: errors?[JsonKeys.firstName]?.first,
          lastNameError: errors?[JsonKeys.lastName]?.first,
          passwordError: errors?[JsonKeys.password]?.first,
          confirmPasswordError: errors?[JsonKeys.passwordConfirmation]?.first,
          error: e.message,
        ));
      } catch (e) {
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
        final stored = await _storeUserData(result);
        if (stored) {
          emit(const LoginSuccessState());
          return;
        }
      } on AuthException catch (e) {
        final errors = e.errors;
        emit(LoginFailureState(
          emailError: errors?[JsonKeys.email]?.first,
          passwordError: errors?[JsonKeys.email]?.first,
          error: e.message,
        ));
      } catch (e) {
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
          final deleted = await _userRepo.deleteLocalUser();
          if (deleted && deletedToken) {
            emit(const LogoutSuccessState());
            return;
          }
          emit(const LogoutErrorState('some error happened'));
        }
        emit(const LogoutErrorState('some error happened'));
      } catch (e) {
        emit(LogoutErrorState(e.toString()));
      }
    });
  }
}
