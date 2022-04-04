import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository _repository;
  GetProductsByCategory(this._repository);
  Future<List<Product>> run(Category category) =>
      _repository.getProductsByCategory(category);
}
