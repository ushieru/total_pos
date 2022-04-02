import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

final user = User('admin', 'admin', Role.admin, 'admin');

class UserInMemory extends UserRepository {
  static final Map<String, User> _users = <String, User>{user.id: user};

  @override
  Future<List<User>> getAll() async {
    return _users.values.toList();
  }

  @override
  Future<User> getByID(String id) async {
    final user = _users[id];
    if (user == null) {
      throw '<UserInMemory> User not found';
    }
    return user;
  }

  @override
  Future<User> create(User object) async {
    if (_users.containsKey(object.id)) {
      throw '<UserInMemory> ID duplicate';
    }
    _users[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(User object) async {
    _users.remove(object.id);
    return;
  }

  @override
  Future<User> update(User object) async {
    if (!_users.containsKey(object.id)) {
      throw '<UserInMemory> User not found';
    }
    _users[object.id] = object;
    return object;
  }

  @override
  Future<User> getUserByAccount(Account account) async {
    return _users.values.firstWhere((user) => account.id == user.accountId,
        orElse: () => throw '<UserInMemory> User not found');
  }
}
