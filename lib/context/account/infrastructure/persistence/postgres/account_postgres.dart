import 'package:postgres/postgres.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/generic_postgres.dart';

class AccountPostgres extends GenericPostgres<Account>
    implements AccountRepository {
  @override
  Future<Account> getAccountByUserAndPassword(
      String user, String password) async {
    final connection = await pConnection.getConnection();
    final result = await connection.query(
        "SELECT * FROM public.\"account\" WHERE \"user\" = '$user' AND \"password\" = '$password'");
    return genericToPostgreSQLResult(result).first;
  }

  @override
  Account genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    return Account(row[1], row[2], id: row[0]);
  }
}
