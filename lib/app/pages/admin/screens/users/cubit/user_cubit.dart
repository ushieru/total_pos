import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final _accountRepository = GetIt.instance.get<AccountRepository>();
  final _userRepository = GetIt.instance.get<UserRepository>();

  UserCubit() : super(UserInitial()) {
    getUsers();
  }

  void setCurrentRole(Role? role) {
    emit(UserGlobal(state.users, currentRole: role));
  }

  Future<void> setCurrentUser(User? user) async {
    Account? account;
    if (user != null) {
      account = await _accountRepository.getByID(user.accountId);
    }
    emit(UserGlobal(state.users,
        currentRole: state.currentRole,
        currentUser: user,
        currentAccount: account));
  }

  Future<void> getUsers() async {
    final users = await _userRepository.getAll();
    emit(UserGlobal(users));
  }

  Future<void> createUser(String name, String email, String user,
      String password, String confirmPassword) async {
    if (state.currentRole == null) {
      throw 'state.currentRole is null';
    }
    final account = await _accountRepository.create(Account(password, user));
    await _userRepository
        .create(User(name, email, state.currentRole!, account.id));
    getUsers();
  }

  Future<void> updateUser(String name, String email, String user,
      String password, String confirmPassword) async {
    if (state.currentUser == null) {
      throw '<UserCubit> currentUser is null';
    }
    final account =
        await _accountRepository.getByID(state.currentUser!.accountId);
    _accountRepository.update(Account(
        password.isEmpty ? account.password : password, user,
        id: account.id));
    final _user = await _userRepository.update(User(
        name, email, state.currentRole!, account.id,
        id: state.currentUser!.id));
    await _userRepository.update(_user);
    getUsers();
  }

  Future<void> deleteUser(User user) async {
    await _userRepository.delete(user);
    getUsers();
  }
}
