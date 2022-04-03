import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/in_memory/account_in_memory.dart';
import 'package:total_pos/context/shared/application/create.dart';
import 'package:total_pos/context/shared/application/get_all.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/in_memory/user_in_memory.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AccountRepository _accountRepository = AccountInMemory();
  final UserRepository _userRepository = UserInMemory();

  UserCubit() : super(UserInitial()) {
    getUsers();
  }

  void setCurrentRole(Role role) {
    emit(UserGlobal(state.users, currentRole: role));
  }

  Future<void> getUsers() async {
    final users = await GetAll(_userRepository).run();
    emit(UserGlobal(users));
  }

  Future<void> createUser(String name, String email, String user,
      String password, String confirmPassword) async {
    if (state.currentRole == null) {
      throw 'state.currentRole is null';
    }
    final account =
        await Create(_accountRepository).run(Account(password, user));
    await Create(_userRepository)
        .run(User(name, email, state.currentRole!, account.id));
    getUsers();
  }
}
