import 'package:objectbox/objectbox.dart';
import 'package:total_pos/context/category/domain/category.dart';

@Entity()
class Product {
  int id;
  String name;
  String description;
  double price;

  final category = ToOne<Category>();

  Product(
      {this.id = 0, this.name = '', this.description = '', this.price = 0.0});

  @override
  String toString() =>
      'Product(id: $id, name: $name, description: $description, price: $price, categorie: $category)';
}
