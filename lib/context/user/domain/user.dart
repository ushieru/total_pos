import 'package:total_pos/context/user/domain/role.dart';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final String email;
  final Role role;
  final String accountId;

  User(this.name, this.email, this.role, this.accountId, {String? id})
      : id = id ?? const Uuid().v4();
}
