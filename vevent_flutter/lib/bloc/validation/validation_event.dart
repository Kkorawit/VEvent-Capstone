part of 'validation_bloc.dart';

@immutable
sealed class ValidationEvent {}

// ignore: camel_case_types
class validateGPS extends ValidationEvent{
  final String uEmail;
  final String eId;

  validateGPS({required this.uEmail, required this.eId});
}
