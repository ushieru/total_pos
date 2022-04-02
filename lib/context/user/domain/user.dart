import 'package:total_pos/context/user/domain/role.dart';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String name;
  final String email;
  final Role role;
  final String accountId;

  User._(this.id, this.name, this.email, this.role, this.accountId);

  User(String name, String email, Role role, String accountId)
      : this._(const Uuid().v4(), name, email, role, accountId);

  User.fromJson(dynamic json)
      : this._(json['id'], json['name'], json['email'], json['role'],
            json['accountId']);
}
