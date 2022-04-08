import 'package:total_pos/context/shared/domain/model.dart';
import 'package:total_pos/context/shared/domain/query_builder_repository.dart';

class PostgresQueryBuilder extends QueryBuilderRepository {
  final String schema;

  PostgresQueryBuilder({this.schema = 'public'});

  @override
  String delete(Model model) {
    return 'DELETE FROM $schema."${getTablename(model)}" '
        'WHERE id = ${model.toJson()['id']}';
  }

  @override
  String findAll<T>() {
    return 'SELECT * FROM $schema."${T.runtimeType.toString().toLowerCase()}"';
  }

  @override
  String findById<T>(String id) {
    return 'SELECT * FROM $schema."${T.runtimeType.toString().toLowerCase()}" '
        'WHERE id = \'$id\'';
  }

  @override
  String insert(Model model) {
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
  String update(Model model) {
    return 'UPDATE $schema."${getTablename(model)}" '
        'SET ${model.toJson().entries.map((e) => '"${e.key}" = ${e.value.runtimeType == String ? "'${e.value}'" : e.value}').join(', ')} '
        'WHERE id = ${model.toJson()['id']}';
  }
}
