import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vevent_flutter/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  UserBloc(this.repository) : super(UserInitial()) {
    on<getUser>((event, emit) async {
      emit(UserLoadingState());
      try{
        Map user = await repository.getUserByUserEmail(event.uEmail);
        emit(UserFinishState(user: user));

      }catch (e){
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
