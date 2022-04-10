import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:total_pos/context/shared/infrastructure/builder/postgres_query_builder.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/postgres_connection.dart';

abstract class GenericPostgres<T extends Serializable>
    implements GenericCrudRepository<T> {
  final pConnection = PostgresConnection();
  final queryBuilderRepository = PostgresQueryBuilder();

  @override
  Future<T> create(T object) async {
    final connection = await pConnection.getConnection();
    final query = queryBuilderRepository.insert(object);
    debugQueryPrinter(query);
    await connection.query(query);
    return object;
  }

  @override
  Future<void> delete(T object) async {
    final connection = await pConnection.getConnection();
    final query = queryBuilderRepository.delete(object);
    debugQueryPrinter(query);
    await connection.query(query);
  }

  @override
  Future<List<T>> getAll() async {
    final connection = await pConnection.getConnection();
    final query = queryBuilderRepository.findAll<T>();
    debugQueryPrinter(query);
    final result = await connection.query(query);
    return genericToPostgreSQLResult(result);
  }

  @override
  Future<T> getByID(String id) async {
    final connection = await pConnection.getConnection();
    final query = queryBuilderRepository.findById<T>(id);
    debugQueryPrinter(query);
    final result = await connection.query(query);
    return genericToPostgreSQLResult(result).first;
  }

  @override
  Future<T> update(T object) async {
    final connection = await pConnection.getConnection();
    final query = queryBuilderRepository.update(object);
    debugQueryPrinter(query);
    connection.query(query);
    return object;
  }

  T genericToPostgreSQLResultRow(PostgreSQLResultRow row);

  List<T> genericToPostgreSQLResult(PostgreSQLResult result) {
    return result.map((row) => genericToPostgreSQLResultRow(row)).toList();
  }

  void debugQueryPrinter(String query) {
    print('<GenericPostgres extends ${T.runtimeType}> query: $query');
  }
}
