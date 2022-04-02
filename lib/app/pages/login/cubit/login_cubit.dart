import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/application/get_account_by_user_and_password.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/in_memory/account_in_memory.dart';
import 'package:total_pos/context/user/application/get_user_by_account.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/in_memory/user_in_memory.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AccountRepository _accountRepository = AccountInMemory();
  final UserRepository _userRepository = UserInMemory();

  LoginCubit() : super(LoginInitial());

  Future<void> login(String user, String password) async {
    try {
      Account account = await GetAccountByUserAndPassword(_accountRepository)
          .run(user, password);
      await GetUserByAccount(_userRepository).run(account);
      emit(LoginSuccessful());
    } catch (e) {
      stderr.writeln(e.toString());
    }
  }
}
