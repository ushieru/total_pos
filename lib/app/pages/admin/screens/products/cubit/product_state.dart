part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  final List<Product> products;
  final List<Category> categories;
  final Category? currentCategory;
  final Product? currentProduct;
  const ProductState(this.products, this.categories, this.currentCategory,
      this.currentProduct);
}

class ProductInitial extends ProductState {
  ProductInitial() : super([], [], null, null);
}

class ProductGlobal extends ProductState {
  const ProductGlobal(List<Product> products, List<Category> categories,
      {Category? currentCategory, Product? currentProduct})
      : super(products, categories, currentCategory, currentProduct);
}
