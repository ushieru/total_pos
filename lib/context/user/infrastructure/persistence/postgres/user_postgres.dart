import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/domain/query_builder_repository.dart';
import 'package:total_pos/context/shared/infrastructure/builder/postgres_query_builder.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/postgres_connection.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

class UserPostgres extends UserRepository {
  final PostgresConnection _connection = PostgresConnection(
      'total_pos', 'postgres', 'postgres',
      host: 'localhost', port: 5432);
  final QueryBuilderRepository _queryBuilderRepository = PostgresQueryBuilder();

  @override
  Future<User> create(User user) async {
    final connection = await _connection.getConnection();
    await connection.query(_queryBuilderRepository.insert(user));
    return user;
  }

  @override
  Future<void> delete(User user) async {
    final connection = await _connection.getConnection();
    await connection.query(_queryBuilderRepository.delete(user));
  }

  @override
  Future<List<User>> getAll() async {
    final connection = await _connection.getConnection();
    final result =
        await connection.query(_queryBuilderRepository.findAll<User>());
    return usersToPostgreSQLResult(result);
  }

  @override
  Future<User> getByID(String id) async {
    final connection = await _connection.getConnection();
    final result =
        await connection.query(_queryBuilderRepository.findById<User>(id));
    return usersToPostgreSQLResult(result).first;
  }

  @override
  Future<User> getUserByAccount(Account account) async {
    final connection = await _connection.getConnection();
    final result = await connection.query(
        "SELECT * FROM public.\"user\" WHERE \"accountId\" = '${account.id}'");
    return usersToPostgreSQLResult(result).first;
  }

  @override
  Future<User> update(User user) async {
    final connection = await _connection.getConnection();
    connection.query(_queryBuilderRepository.update(user));
    return user;
  }

  User userToPostgreSQLResultRow(PostgreSQLResultRow row) {
    return User(row[1], row[2], stringToRole(row[3]), row[4], id: row[0]);
  }

  List<User> usersToPostgreSQLResult(PostgreSQLResult result) {
    return result.map((row) => userToPostgreSQLResultRow(row)).toList();
  }
}
