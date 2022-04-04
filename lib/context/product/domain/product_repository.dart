import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';

abstract class ProductRepository implements GenericCrudRepository<Product> {
  Future<List<Product>> getProductsByCategory(Category category);
}
