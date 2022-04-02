import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/user/domain/user.dart';

abstract class UserRepository implements GenericCrudRepository<User> {
  Future<User> getUserByAccount(Account account);
}
