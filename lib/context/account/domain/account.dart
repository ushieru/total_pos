import 'package:objectbox/objectbox.dart';

@Entity()
class Account {
  int id;
  String password;
  String user;

  Account({this.id = 0, this.password = '', this.user = ''});

  @override
  String toString() => 'Account(id: $id, password: $password, user: $user)';
}
