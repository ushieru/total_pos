part of 'category_cubit.dart';

@immutable
abstract class CategoryState {
  final List<Category> categories;
  final Category? currentCategory;
  const CategoryState(this.categories, {this.currentCategory});
}

class CategoryInitial extends CategoryState {
  CategoryInitial() : super([]);
}

class CategoryGlobal extends CategoryState {
  const CategoryGlobal(List<Category> categories, {Category? currentCategory})
      : super(categories, currentCategory: currentCategory);
}
