import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';

class GetAccountByUserAndPassword {
  final AccountRepository _repository;
  GetAccountByUserAndPassword(this._repository);
  Future<Account> run(String user, String password) =>
      _repository.getAccountByUserAndPassword(user, password);
}
