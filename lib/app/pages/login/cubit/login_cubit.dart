import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _accountRepository = GetIt.instance.get<AccountRepository>();
  final _userRepository = GetIt.instance.get<UserRepository>();

  LoginCubit() : super(LoginInitial());

  Future<void> login(String user, String password) async {
    try {
      Account account =
          await _accountRepository.getAccountByUserAndPassword(user, password);
      final _user = await _userRepository.getUserByAccount(account);
      emit(LoginSuccessful(_user));
    } catch (e) {}
  }
}
