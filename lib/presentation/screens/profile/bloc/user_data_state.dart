part of 'user_data_bloc.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();
  
  @override
  List<Object> get props => [];
}

final class UserDataInitial extends UserDataState {}
