part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

// ignore: camel_case_types
class signIn extends SignInEvent {
  final String? uEmail;
  final String? role;
  final String? displayName;
  final String? profileURL;

  signIn({required this.uEmail, required this.role, required this.displayName, required this.profileURL});

  
}
