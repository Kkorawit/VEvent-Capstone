part of 'user_bloc.dart';

@immutable
sealed class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}

class UserFinishState extends UserState {
  final Map user;

  UserFinishState({required this.user});
}

