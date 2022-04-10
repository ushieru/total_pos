import 'package:postgres/postgres.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/generic_postgres.dart';

class ProdcutPostgres extends GenericPostgres<Product>
    implements ProductRepository {
  @override
  genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    return Product(
        row[1], row[2], double.tryParse(row[3] as String) ?? 0.0, row[4],
        id: row[0]);
  }

  @override
  Future<List<Product>> getProductsByCategory(Category category) async {
    final connection = await pConnection.getConnection();
    final result = await connection.query(
        "SELECT * FROM public.\"product\" WHERE \"caegoryId\" = '${category.id}'");
    return genericToPostgreSQLResult(result);
  }
}
