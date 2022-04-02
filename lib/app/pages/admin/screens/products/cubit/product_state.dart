part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  final List<Product> products;
  final List<Category> categories;
  final Category? currentCategory;

  const ProductState(this.products, this.categories, this.currentCategory);
}

class ProductInitial extends ProductState {
  ProductInitial() : super([], [], null);
}

class ProductGlobal extends ProductState {
  const ProductGlobal(List<Product> products, List<Category> categories,
      {Category? currentCategory})
      : super(products, categories, currentCategory);
}
