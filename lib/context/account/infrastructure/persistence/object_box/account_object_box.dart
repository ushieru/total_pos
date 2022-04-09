import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/object_box/generic_object_box.dart';

class AccountObjectBox extends GenericObjectBox<Account>
    implements AccountRepository {
  @override
  Future<Account> getAccountByUserAndPassword(String user, String password) {
    // TODO: implement getAccountByUserAndPassword
    throw UnimplementedError();
  }
}
