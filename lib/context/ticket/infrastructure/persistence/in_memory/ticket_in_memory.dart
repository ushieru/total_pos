import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

class TicketInMemory extends TicketRepository {
  static final Map<String, Ticket> _tickets = <String, Ticket>{};

  @override
  Future<List<Ticket>> getAll() async {
    return _tickets.values.toList();
  }

  @override
  Future<Ticket> getByID(String id) async {
    final product = _tickets[id];
    if (product == null) {
      throw '<TicketInMemory> Product not found';
    }
    return product;
  }

  @override
  Future<Ticket> create(Ticket object) async {
    if (_tickets.containsKey(object.id)) {
      throw '<TicketInMemory> ID duplicate';
    }
    _tickets[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(Ticket object) async {
    _tickets.remove(object.id);
    return;
  }

  @override
  Future<Ticket> update(Ticket object) async {
    if (!_tickets.containsKey(object.id)) {
      throw '<TicketInMemory> Product not found';
    }
    _tickets[object.id] = object;
    return object;
  }

  @override
  Future<Ticket> addTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) async {
    if (!_tickets.containsKey(ticket.id)) {
      final newTicket = Ticket([ticketProduct], id: ticket.id);
      _tickets[ticket.id] = newTicket;
      return newTicket;
    }
    final oldTicket = _tickets[ticket.id]!;
    try {
      oldTicket.ticketProducts.firstWhere(
          (oldTicketProduct) => oldTicketProduct.id == ticketProduct.id);

      final ticketProducts = oldTicket.ticketProducts
          .map((oldTicketProduct) => oldTicketProduct.id == ticketProduct.id
              ? TicketProduct(ticketProduct.product,
                  quantity: oldTicketProduct.quantity + 1)
              : oldTicketProduct)
          .toList();
      final newTicket = Ticket(ticketProducts, id: oldTicket.id);
      _tickets[ticket.id] = newTicket;
      return newTicket;
    } catch (e) {
      final newTicket = Ticket([...oldTicket.ticketProducts, ticketProduct],
          id: oldTicket.id);
      _tickets[ticket.id] = newTicket;
      return newTicket;
    }
  }

  @override
  Future<Ticket> removeTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) async {
    if (!_tickets.containsKey(ticket.id)) {
      throw '<TicketInMemory> Ticket not found';
    }
    final oldTicket = _tickets[ticket.id]!;
    oldTicket.ticketProducts.firstWhere(
        (oldTicketProduct) => oldTicketProduct.id == ticketProduct.id);

    final ticketProducts = oldTicket.ticketProducts
        .map((oldTicketProduct) => oldTicketProduct.id == ticketProduct.id
            ? TicketProduct(ticketProduct.product,
                quantity: oldTicketProduct.quantity - 1)
            : oldTicketProduct)
        .where((oldTicketProduct) => oldTicketProduct.quantity > 0)
        .toList();
    final newTicket = Ticket(ticketProducts, id: oldTicket.id);
    _tickets[ticket.id] = newTicket;
    return newTicket;
  }
}
