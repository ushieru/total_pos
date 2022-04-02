import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';

final category1 = Category('Desayunos');
final category2 = Category('Bebidas');

class CategoryInMemory extends CategoryRepository {
  static final Map<String, Category> _categories = <String, Category>{
    category1.id: category1,
    category2.id: category2,
  };

  @override
  Future<List<Category>> getAll() async {
    return _categories.values.toList();
  }

  @override
  Future<Category> getByID(String id) async {
    final category = _categories[id];
    if (category == null) {
      throw '<CategoryInMemory> Category not found';
    }
    return category;
  }

  @override
  Future<Category> create(Category object) async {
    if (_categories.containsKey(object.id)) {
      throw '<CategoryInMemory> ID Duplicate';
    }
    _categories[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(Category object) async {
    _categories.remove(object.id);
    return;
  }

  @override
  Future<Category> update(Category object) async {
    if (!_categories.containsKey(object.id)) {
      throw '<ProductInMemory> Product not found';
    }
    _categories[object.id] = object;
    return object;
  }
}
