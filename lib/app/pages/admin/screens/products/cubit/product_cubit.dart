import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/in_memory/category_in_memory.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/in_memory/product_in_memory.dart';
import 'package:total_pos/context/shared/application/create.dart';
import 'package:total_pos/context/shared/application/delete.dart';
import 'package:total_pos/context/shared/application/get_all.dart';
import 'package:total_pos/context/shared/application/update.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository = ProductInMemory();
  final CategoryRepository _categoryRepository = CategoryInMemory();

  ProductCubit() : super(ProductInitial()) {
    getProducts();
    getCategories();
  }

  Future<void> addProduct(String name, String description, double price) async {
    if (state.currentCategory == null) return;
    final product =
        Product(name, description, price, state.currentCategory!.id);
    await Create(_productRepository).run(product);
    getProducts();
  }

  Future<void> getProducts() async {
    final products = await GetAll(_productRepository).run();
    emit(ProductGlobal(products, state.categories));
  }

  Future<void> getCategories() async {
    final categories = await GetAll(_categoryRepository).run();
    emit(ProductGlobal(state.products, categories,
        currentCategory: state.currentCategory,
        currentProduct: state.currentProduct));
  }

  Future<void> setCurrentCategory(Category? category) async {
    emit(ProductGlobal(state.products, state.categories,
        currentCategory: category, currentProduct: state.currentProduct));
  }

  Future<Product?> setCurrentProduct(Product? product) async {
    emit(ProductGlobal(state.products, state.categories,
        currentCategory: state.currentCategory, currentProduct: product));
    return product;
  }

  Future<void> updateProduct(Product product) async {
    await Update(_productRepository).run(product);
    getProducts();
  }

  Future<void> deleteProduct(Product product) async {
    await Delete(_productRepository).run(product);
    getProducts();
  }
}
