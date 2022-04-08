import 'package:total_pos/context/shared/domain/model.dart';

abstract class QueryBuilderRepository {
  String findAll<T>();
  String findById<T>(String id);
  String insert(Model model);
  String update(Model model);
  String delete(Model model);
  String getTablename(Model model) => model.runtimeType.toString().toLowerCase();
}
