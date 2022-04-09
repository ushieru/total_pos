import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/user/domain/user.dart';

abstract class AccountRepository implements GenericCrudRepository<Account> {
  Future<Account> getAccountByUserAndPassword(String user, String password);
}
