part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final List<User> users;
  final Role? currentRole;
  const UserState(this.users, {this.currentRole});
}

class UserInitial extends UserState {
  UserInitial() : super([]);
}

class UserGlobal extends UserState {
  const UserGlobal(List<User> users, {Role? currentRole})
      : super(users, currentRole: currentRole);
}
