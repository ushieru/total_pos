part of 'session_cubit.dart';

@immutable
abstract class SessionState {
  final User? user;
  final bool redirect;
  const SessionState(this.user, this.redirect);
}

class SessionInitial extends SessionState {
  const SessionInitial(User? user, {bool redirect = true})
      : super(user, redirect);
}
