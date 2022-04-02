import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';

class ProductInMemory extends ProductRepository {
  static final Map<String, Product> _products = <String, Product>{};

  @override
  Future<List<Product>> getAll() async {
    return _products.values.toList();
  }

  @override
  Future<Product> getByID(String id) async {
    final product = _products[id];
    if (product == null) {
      throw '<ProductInMemory> Product not found';
    }
    return product;
  }

  @override
  Future<Product> create(Product object) async {
    if (_products.containsKey(object.id)) {
      throw '<ProductInMemory> ID duplicate';
    }
    _products[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(Product object) async {
    _products.remove(object.id);
    return;
  }

  @override
  Future<Product> update(Product object) async {
    if (!_products.containsKey(object.id)) {
      throw '<ProductInMemory> Product not found';
    }
    _products[object.id] = object;
    return object;
  }
}
