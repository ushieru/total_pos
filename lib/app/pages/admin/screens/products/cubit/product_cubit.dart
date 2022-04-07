import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final _productRepository = GetIt.instance.get<ProductRepository>();
  final _categoryRepository = GetIt.instance.get<CategoryRepository>();

  ProductCubit() : super(ProductInitial()) {
    getProducts();
    getCategories();
  }

  Future<void> addProduct(String name, String description, double price) async {
    if (state.currentCategory == null) return;
    final product =
        Product(name, description, price, state.currentCategory!.id);
    await _productRepository.create(product);
    getProducts();
  }

  Future<void> getProducts() async {
    final products = await _productRepository.getAll();
    emit(ProductGlobal(products, state.categories));
  }

  Future<void> getCategories() async {
    final categories = await _categoryRepository.getAll();
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
    await _productRepository.update(product);
    getProducts();
  }

  Future<void> deleteProduct(Product product) async {
    await _productRepository.update(product);
    getProducts();
  }
}
