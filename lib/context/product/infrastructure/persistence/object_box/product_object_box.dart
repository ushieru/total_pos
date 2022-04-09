import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/object_box/generic_object_box.dart';

class ProductObjectBox extends GenericObjectBox<Product>
    implements ProductRepository {
  @override
  Future<List<Product>> getProductsByCategory(Category category) {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
}
