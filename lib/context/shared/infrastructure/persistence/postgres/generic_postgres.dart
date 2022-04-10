import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:total_pos/context/shared/infrastructure/builder/postgres_query_builder.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/postgres_connection.dart';

class GenericPostgres<T extends Serializable>
    implements GenericCrudRepository<T> {
  final pConnection = PostgresConnection();
  final _queryBuilderRepository = PostgresQueryBuilder();

  @override
  Future<T> create(T object) async {
    final connection = await pConnection.getConnection();
    await connection.query(_queryBuilderRepository.insert(object));
    return object;
  }

  @override
  Future<void> delete(T object) async {
    final connection = await pConnection.getConnection();
    await connection.query(_queryBuilderRepository.delete(object));
  }

  @override
  Future<List<T>> getAll() async {
    final connection = await pConnection.getConnection();
    final result = await connection.query(_queryBuilderRepository.findAll<T>());
    return usersToPostgreSQLResult(result);
  }

  @override
  Future<T> getByID(String id) async {
    final connection = await pConnection.getConnection();
    final result =
        await connection.query(_queryBuilderRepository.findById<T>(id));
    return usersToPostgreSQLResult(result).first;
  }

  @override
  Future<T> update(T object) async {
    final connection = await pConnection.getConnection();
    connection.query(_queryBuilderRepository.update(object));
    return object;
  }

  T genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    throw 'Override this method';
  }

  List<T> usersToPostgreSQLResult(PostgreSQLResult result) {
    return result.map((row) => genericToPostgreSQLResultRow(row)).toList();
  }
}
