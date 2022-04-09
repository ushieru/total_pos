part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final List<User> users;
  final String? currentRole;
  final User? currentUser;
  final Account? currentAccount;
  const UserState(this.users,
      {this.currentRole, this.currentUser, this.currentAccount});
}

class UserInitial extends UserState {
  UserInitial() : super([]);
}

class UserGlobal extends UserState {
  const UserGlobal(List<User> users,
      {String? currentRole, User? currentUser, Account? currentAccount})
      : super(users,
            currentRole: currentRole,
            currentUser: currentUser,
            currentAccount: currentAccount);
}
