import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:uuid/uuid.dart';

class Ticket {
  final String id;
  final String userId;
  final DateTime dateTime = DateTime.now();
  final List<TicketProduct> ticketProducts;
  final double total;
  Ticket(this.ticketProducts, this.userId, {String? id})
      : total = ticketProducts.isEmpty
            ? 0
            : ticketProducts
                .map<double>((productTicket) =>
                    productTicket.quantity * productTicket.product.price)
                .reduce((value, element) => value + element),
        id = id ?? const Uuid().v4();

  Ticket.empty(String userId) : this([], userId);
  @override
  String toString() => 'Ticket(id: $id, userId: $userId, dateTime: $dateTime, ticketProducts: $ticketProducts, total: $total)';
}
