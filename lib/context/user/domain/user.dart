import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:uuid/uuid.dart';

class User implements Serializable {
  String id;
  String name;
  String email;
  String role;
  String accountId;

  User(
      {String? id,
      this.name = '',
      this.email = '',
      this.role = '',
      this.accountId = ''})
      : id = id ?? const Uuid().v4();

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
