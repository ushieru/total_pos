part of 'category_cubit.dart';

@immutable
abstract class CategoryState {
  final List<Category> categories;
  const CategoryState(this.categories);
}

class CategoryInitial extends CategoryState {
  CategoryInitial() : super([]);
}

class CategoryGlobal extends CategoryState {
  const CategoryGlobal(List<Category> categories) : super(categories);
}
