import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/object_box/generic_object_box.dart';

class CategoryObjectBox extends GenericObjectBox<Category>
    implements CategoryRepository {}
