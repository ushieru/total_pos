import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

class GetUserByAccount {
  final UserRepository _repository;
  GetUserByAccount(this._repository);
  Future<User> run(Account account) => _repository.getUserByAccount(account);
}
