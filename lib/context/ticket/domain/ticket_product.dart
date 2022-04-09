import 'package:objectbox/objectbox.dart';
import 'package:total_pos/context/product/domain/product.dart';

@Entity()
class TicketProduct {
  int id;
  int quantity;
  final product = ToOne<Product>();

  TicketProduct({
    this.id = 0,
    this.quantity = 0,
  });
  @override
  String toString() =>
      'TicketProduct(id: $id, product: $product, quantity: $quantity)';
}
