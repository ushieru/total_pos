import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
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
  factory Product.fromProduct(TicketProduct ticketProduct) {
    return Product(ticketProduct.name, ticketProduct.description,
        ticketProduct.price, ticketProduct.categoryId,
        id: ticketProduct.id);
  }
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
