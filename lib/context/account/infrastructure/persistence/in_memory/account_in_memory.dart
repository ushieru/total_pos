import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/user/domain/role.dart';

class AccountInMemory extends AccountRepository {
  static final Map<String, Account> _accounts = <String, Account>{};

  @override
  Future<List<Account>> getAll() async {
    return _accounts.values.toList();
  }

  @override
  Future<Account> getByID(String id) async {
    final account = _accounts[id];
    if (account == null) {
      throw '<AccountInMemory> Account not found';
    }
    return account;
  }

  @override
  Future<Account> create(Account object) async {
    if (_accounts.containsKey(object.id)) {
      throw '<AccountInMemory> ID Duplicate';
    }
    _accounts[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(Account object) async {
    _accounts.remove(object.id);
    return;
  }

  @override
  Future<Account> update(Account object) async {
    if (!_accounts.containsKey(object.id)) {
      throw '<AccountInMemory> Account not found';
    }
    _accounts[object.id] = object;
    return object;
  }

  @override
  Future<Account> getAccountByUserAndPassword(
      String user, String password) async {
    return _accounts.values.firstWhere(
        (account) => account.user == user && account.password == password,
        orElse: () => throw '<AccountInMemory> Account not found');
  }

  @override
  Future<List<Account>> getAccountsByRole(Role role) async {
    // Unsuport method in this repository
    return [];
  }
}
