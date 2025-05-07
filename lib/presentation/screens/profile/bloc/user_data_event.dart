part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

final class StoreUserData extends UserDataEvent {
  final UserModel user;
  const StoreUserData(this.user);
  @override
  
  List<Object> get props => [user];
}
