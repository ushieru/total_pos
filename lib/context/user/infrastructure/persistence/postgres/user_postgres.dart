import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/generic_postgres.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

class UserPostgres extends GenericPostgres<User> implements UserRepository {
  @override
  Future<User> getUserByAccount(Account account) async {
    final connection = await pConnection.getConnection();
    final result = await connection.query(
        "SELECT * FROM public.\"user\" WHERE \"accountId\" = '${account.id}'");
    return usersToPostgreSQLResult(result).first;
  }

  @override
  genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    return User(
        id: row[0],
        name: row[1],
        email: row[2],
        role: row[3],
        accountId: row[4]);
  }
}
