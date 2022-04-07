import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final _repository = GetIt.instance.get<CategoryRepository>();

  CategoryCubit() : super(CategoryInitial()) {
    getCategories();
  }

  Future<void> addCategory(Category category) async {
    await _repository.create(category);
    getCategories();
  }

  Future<void> getCategories() async {
    final categories = await _repository.getAll();
    emit(CategoryGlobal(categories));
  }

  Future<void> editCategory(Category category) async {
    await _repository.update(category);
    getCategories();
  }

  Future<Category?> setCurrentCategory(Category? category) async {
    emit(CategoryGlobal(state.categories, currentCategory: category));
    return category;
  }

  Future<void> deleteCategory(Category category) async {
    await _repository.delete(category);
    getCategories();
  }
}
