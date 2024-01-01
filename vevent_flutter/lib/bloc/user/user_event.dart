part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class getUser extends UserEvent {
  final String uEmail;

  getUser({required this.uEmail});
}
