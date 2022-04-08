import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;

  Product(this.name, this.description, this.price, this.categoryId,
      {String? id})
      : id = id ?? const Uuid().v4();

  @override
  String toString() =>
      'Product(id: $id, name: $name, description: $description, price: $price, categoryId: $categoryId)';
}
