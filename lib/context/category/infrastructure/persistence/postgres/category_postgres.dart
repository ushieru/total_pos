import 'package:postgres/postgres.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/generic_postgres.dart';

class CategoryPostgres extends GenericPostgres<Category>
    implements CategoryRepository {
  @override
  genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    return Category(row[1], id: row[0]);
  }
}
