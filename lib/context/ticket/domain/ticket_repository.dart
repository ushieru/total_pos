import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';

abstract class TicketRepository implements GenericCrudRepository<Ticket> {
  Future<Ticket> addTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) async {
    final isTicketProductInTicket = ticket.ticketProducts
        .any((_ticketProduct) => _ticketProduct.id == ticketProduct.id);
    if (isTicketProductInTicket) {
      final ticketProducts = ticket.ticketProducts
          .map((_ticketProduct) => _ticketProduct.id == ticketProduct.id
              ? TicketProduct(ticketProduct.product,
                  quantity: _ticketProduct.quantity + 1)
              : _ticketProduct)
          .toList();
      return Ticket(ticketProducts, id: ticket.id);
    }
    return Ticket([...ticket.ticketProducts, ticketProduct], id: ticket.id);
  }

  Future<Ticket> removeTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) async {
    ticket.ticketProducts
        .firstWhere((_ticketProduct) => _ticketProduct.id == ticketProduct.id);
    final ticketProducts = ticket.ticketProducts
        .map((_ticketProduct) => _ticketProduct.id == ticketProduct.id
            ? TicketProduct(ticketProduct.product,
                quantity: _ticketProduct.quantity - 1)
            : _ticketProduct)
        .where((_ticketProduct) => _ticketProduct.quantity > 0)
        .toList();
    return Ticket(ticketProducts, id: ticket.id);
  }
}
