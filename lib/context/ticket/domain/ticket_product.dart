import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/shared/domain/serializable.dart';

class TicketProduct extends Product implements Serializable {
  final String ticketId;
  final int quantity;
  TicketProduct(Product product, this.ticketId, {int? quantity})
      : quantity = quantity ?? 1,
        super(product.name, product.description, product.price,
            product.categoryId,
            id: product.id);
  @override
  String toString() =>
      'TicketProduct(id: $id, name: $name, description: $description, price: $price, categoryId: $categoryId, ticketId: $ticketId, quantity: $quantity)';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'ticketId': ticketId,
      'quantity': quantity
    };
  }
}
