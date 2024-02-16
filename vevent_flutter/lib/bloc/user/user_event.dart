part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

// ignore: camel_case_types
class getUser extends UserEvent {
  final String uEmail;

  getUser({required this.uEmail});
}
