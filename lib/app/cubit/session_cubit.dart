import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/user/domain/user.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionInitial> {
  SessionCubit() : super(const SessionInitial(null));

  void setSession(User user) => emit(SessionInitial(user));

  void deleteSession({bool redirect = true}) =>
      emit(SessionInitial(null, redirect: redirect));
}
