import 'package:objectbox/objectbox.dart';
import 'package:total_pos/context/account/domain/account.dart';

@Entity()
class User {
  int id;
  String name;
  String email;
  String role;

  final account = ToOne<Account>();

  User({this.id = 0, this.name = '', this.email = '', this.role = 'User'});

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, role: $role, accountId: ${account.target})';
}
