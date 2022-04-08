import 'package:total_pos/context/product/domain/product.dart';

class TicketProduct {
  final String id;
  final Product product;
  final int quantity;
  TicketProduct(this.product, {int? quantity})
      : quantity = quantity ?? 1,
        id = product.id;
  @override
  String toString() => 'TicketProduct(id: $id, product: $product, quantity: $quantity)';
}
