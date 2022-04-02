import 'package:uuid/uuid.dart';

class Account {
  final String id;
  final String password;
  final String user;

  Account._(this.id, this.password, this.user);

  Account(String password, String user)
      : this._(const Uuid().v4(), password, user);

  Account.fromJson(dynamic json)
      : this._(json['id'], json['password'], json['user']);
}
