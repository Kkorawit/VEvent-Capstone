part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInErrorState extends SignInState {
  final String message;

  SignInErrorState(this.message);
}

class SignInFinishState extends SignInState {
  final bool signInSuccess;
  final String uEmail;
  final String role;

  SignInFinishState({required this.signInSuccess, required this.uEmail, required this.role});
}
