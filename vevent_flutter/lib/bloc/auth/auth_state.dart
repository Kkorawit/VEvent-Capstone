part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}

class AuthFinishState extends AuthState {
  // final FlutterSecureStorage storage;
  final String status; 

  AuthFinishState({required this.status});
}
