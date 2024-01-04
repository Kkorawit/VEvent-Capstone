part of 'validation_bloc.dart';

@immutable
sealed class ValidationEvent {}

class validateGPS extends ValidationEvent{
  final String uEmail;
  final String eId;

  validateGPS({required this.uEmail, required this.eId});
}
