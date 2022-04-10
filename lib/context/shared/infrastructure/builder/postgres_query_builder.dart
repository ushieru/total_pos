import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:total_pos/context/shared/domain/query_builder_repository.dart';

class PostgresQueryBuilder extends QueryBuilderRepository {
  final String schema;

  PostgresQueryBuilder({this.schema = 'public'});

  @override
  String delete(Serializable model) {
    return 'DELETE FROM $schema."${getTablename(model)}" '
        'WHERE id = \'${model.toJson()['id']}\'';
  }

  @override
  String findAll<T>() {
    return 'SELECT * FROM $schema."${T.toString().toLowerCase()}"';
  }

  @override
  String findById<T>(String id) {
    return 'SELECT * FROM $schema."${T.toString().toLowerCase()}" '
        'WHERE id = \'$id\'';
  }

  @override
  String insert(Serializable model) {
    var payload = model.toJson();
    var columns = payload.keys.map((e) => '"$e"').join(', ');
    var values = payload.values
        .map((e) => e.runtimeType == String ? "'$e'" : e)
        .join(', ');
    var query = 'INSERT INTO $schema."${getTablename(model)}" ($columns) '
        'VALUES ($values)';
    return query;
  }

  @override
  String update(Serializable model) {
    return 'UPDATE $schema."${getTablename(model)}" '
        'SET ${model.toJson().entries.map((e) => '"${e.key}" = ${e.value.runtimeType == String ? "'${e.value}'" : e.value}').join(', ')} '
        'WHERE id = \'${model.toJson()['id']}\'';
  }
}
