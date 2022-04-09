import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/object_box/generic_object_box.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

class UserObjectBox extends GenericObjectBox<User> implements UserRepository {
  @override
  Future<User> getUserByAccount(Account account) {
    // TODO: implement getUserByAccount
    throw UnimplementedError();
  }
}
