part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessful extends LoginState {
  final User user;
  LoginSuccessful(this.user);
}
