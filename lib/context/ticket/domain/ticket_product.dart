import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/shared/domain/serializable.dart';

class TicketProduct implements Serializable {
  final String id;
  final Product product;
  final int quantity;
  TicketProduct(this.product, {int? quantity})
      : quantity = quantity ?? 1,
        id = product.id;
  @override
  String toString() =>
      'TicketProduct(id: $id, product: $product, quantity: $quantity)';

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'product': product, 'quantity': quantity};
  }
}
