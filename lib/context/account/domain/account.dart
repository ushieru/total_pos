import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:uuid/uuid.dart';

class Account implements Serializable {
  final String id;
  final String password;
  final String user;
  Account(this.password, this.user, {String? id})
      : id = id ?? const Uuid().v4();
  @override
  String toString() => 'Account(id: $id, password: $password, user: $user)';
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'password': password,
        'user': user,
      };
}
