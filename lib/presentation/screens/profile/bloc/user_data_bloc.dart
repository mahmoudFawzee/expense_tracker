import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/repositories/user_repo.dart';
import 'package:expense_tracker/domain/entities/user.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final UserDataRepo _userDataRepo;
  UserDataBloc(this._userDataRepo) : super(const UserDataInitial()) {
    on<FetchUserDataEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        final user = await _userDataRepo.getUser();
        if (user == null) {
          emit(const UserDateErrorState(error: 'un expected error'));
          return;
        }
        emit(FetchedUserDataState(user));
      } catch (e) {
        emit(UserDateErrorState(error: e.toString()));
      }
    });

    on<UpdateUserDateEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        //?we are logged in so we already have a stored local user
        //?so we get the old user data and compare the email with the old one
        final oldUser = await _userDataRepo.getUser();
        if (oldUser?.email != event.user.email) {
          emit(AskEmailUpdateConfirmationState(event.user));
          return;
        }
        //?now no need to ask any confirmation we just update data from backend
        final updatedUser = await _userDataRepo.updateUser(event.user) as User?;
        if (updatedUser != null) {
          emit(const UpdatedUserDataState());
          return;
        }
        emit(const UserDateErrorState(error: 'user data update error'));
      } catch (e) {
        emit(UserDateErrorState(error: e.toString()));
      }
    });

    on<ConfirmUpdateEmailEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        final updatedUser = await _userDataRepo.updateUser(event.user) as User?;
        if (updatedUser != null) {
          emit(const UpdatedUserEmailState());
          return;
        }
        emit(const UserDateErrorState(error: 'some error happened'));
      } catch (e) {
        emit(UserDateErrorState(error: e.toString()));
      }
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(const UserDataLoadingState());
      try {
        final isDeleted = await _userDataRepo.deleteUser(event.password);
        if (isDeleted) {
          emit(const DeletedUserState());
          return;
        }
        emit(const UserDateErrorState(error: 'user deleting error'));
      } catch (e) {
        emit(UserDateErrorState(error: e.toString()));
      }
    });
  }
}
