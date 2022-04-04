import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/in_memory/category_in_memory.dart';
import 'package:total_pos/context/product/applications/get_products_by_category.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/in_memory/product_in_memory.dart';
import 'package:total_pos/context/shared/application/get_all.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  final CategoryRepository _categoryRepository = CategoryInMemory();
  final ProductRepository _productRepository = ProductInMemory();

  CashierCubit() : super(CashierInitial()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await GetAll(_categoryRepository).run();
    emit(CashierGlobal(categories, const []));
    if (categories.isNotEmpty) {
      loadProductsByCategory(categories[0]);
    }
  }

  Future<void> loadProductsByCategory(Category category) async {
    if (state.currentCategory != null &&
        category.id == state.currentCategory!.id) return;
    final products =
        await GetProductsByCategory(_productRepository).run(category);
    emit(CashierGlobal(state.categories, products, currentCategory: category));
  }
}
