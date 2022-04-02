part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final List<Account> account;
  final List<User> users;
  const UserState(this.users, this.account);
}

class UserInitial extends UserState {
  UserInitial() : super([], []);
}
