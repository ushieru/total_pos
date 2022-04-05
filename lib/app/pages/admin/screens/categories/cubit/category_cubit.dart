import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/in_memory/category_in_memory.dart';
import 'package:total_pos/context/shared/application/create.dart';
import 'package:total_pos/context/shared/application/delete.dart';
import 'package:total_pos/context/shared/application/get_all.dart';
import 'package:total_pos/context/shared/application/update.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _repository = CategoryInMemory();

  CategoryCubit() : super(CategoryInitial()) {
    getCategories();
  }

  Future<void> addCategory(Category category) async {
    await Create(_repository).run(category);
    getCategories();
  }

  Future<void> getCategories() async {
    final categories = await GetAll(_repository).run();
    emit(CategoryGlobal(categories));
  }

  Future<void> editCategory(Category category) async {
    await Update(_repository).run(category);
    getCategories();
  }

  Future<Category?> setCurrentCategory(Category? category) async {
    emit(CategoryGlobal(state.categories, currentCategory: category));
    return category;
  }

  Future<void> deleteCategory(Category category) async {
    await Delete(_repository).run(category);
    getCategories();
  }
}
