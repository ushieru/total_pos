import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/user/domain/user.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<User?> {
  SessionCubit() : super(null);

  void setSession(User user) => emit(user);
  void deleteSession() => emit(null);
}
