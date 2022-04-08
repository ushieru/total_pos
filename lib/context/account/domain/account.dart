import 'package:uuid/uuid.dart';

class Account {
  final String id;
  final String password;
  final String user;

  Account(this.password, this.user, {String? id})
      : id = id ?? const Uuid().v4();

  @override
  String toString() => 'Account(id: $id, password: $password, user: $user)';
}
