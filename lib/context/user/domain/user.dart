import 'package:total_pos/context/shared/domain/model.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:uuid/uuid.dart';

class User implements Model {
  final String id;
  final String name;
  final String email;
  final String role;
  final String accountId;

  User(this.name, this.email, Role role, this.accountId, {String? id})
      : role = role.name,
        id = id ?? const Uuid().v4();

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, role: $role, accountId: $accountId)';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'accountId': accountId,
    };
  }
}
