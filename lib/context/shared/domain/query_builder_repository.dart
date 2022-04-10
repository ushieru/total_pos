import 'package:total_pos/context/shared/domain/serializable.dart';

abstract class QueryBuilderRepository {
  String findAll<T>();
  String findById<T>(String id);
  String insert(Serializable model);
  String update(Serializable model);
  String delete(Serializable model);
  String getTablename(Serializable model) => model.runtimeType.toString().toLowerCase();
}
