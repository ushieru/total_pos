import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:uuid/uuid.dart';

class Ticket {
  final String id;
  final List<TicketProduct> ticketProducts;
  final double total;
  Ticket(this.ticketProducts, {String? id})
      : total = ticketProducts.isEmpty
            ? 0
            : ticketProducts
                .map<double>((productTicket) =>
                    productTicket.quantity * productTicket.product.price)
                .reduce((value, element) => value + element),
        id = id ?? const Uuid().v4();
  Ticket.empty() : this([]);
}
