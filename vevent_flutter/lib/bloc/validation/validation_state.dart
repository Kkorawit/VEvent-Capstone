part of 'validation_bloc.dart';

@immutable
sealed class ValidationState {}

class ValidationInitial extends ValidationState {}

class ValidationLoadingState extends ValidationState {}

class ValidationErrorState extends ValidationState {
  final String message;

  ValidationErrorState(this.message);
}

class ValidationFinishState extends ValidationState {
  final ValidationResponse validateRes;
  ValidationFinishState({required this.validateRes});
}
