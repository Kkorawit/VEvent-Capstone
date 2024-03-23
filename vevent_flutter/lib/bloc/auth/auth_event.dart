part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class authUser extends AuthEvent {
  final String uEmail;
  final String displayName;
  final String role;
  final String? photoURL;

  authUser({required this.uEmail, required this.displayName, required this.role, required this.photoURL});

  
}