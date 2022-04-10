import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:uuid/uuid.dart';

class Product implements Serializable {
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
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId
      };
}
