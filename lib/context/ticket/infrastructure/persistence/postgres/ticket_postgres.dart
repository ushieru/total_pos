import 'package:postgres/postgres.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/generic_postgres.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

class TicketPostgres extends GenericPostgres<Ticket>
    implements TicketRepository {
  @override
  Future<Ticket> addTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) async {
    final isTicketProductInTicket = ticket.ticketProducts
        .any((_ticketProduct) => _ticketProduct.id == ticketProduct.id);
    if (isTicketProductInTicket) {
      final ticketProducts = ticket.ticketProducts
          .map((_ticketProduct) => _ticketProduct.id == ticketProduct.id
              ? TicketProduct(Product.fromProduct(ticketProduct), ticket.id,
                  quantity: _ticketProduct.quantity + 1)
              : _ticketProduct)
          .toList();
      return Ticket(ticketProducts, ticket.userId, id: ticket.id);
    }
    return Ticket([...ticket.ticketProducts, ticketProduct], ticket.userId,
        id: ticket.id);
  }

  @override
  Future<Ticket> removeTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) async {
    ticket.ticketProducts
        .firstWhere((_ticketProduct) => _ticketProduct.id == ticketProduct.id);
    final ticketProducts = ticket.ticketProducts
        .map((_ticketProduct) => _ticketProduct.id == ticketProduct.id
            ? TicketProduct(Product.fromProduct(ticketProduct), ticket.id,
                quantity: _ticketProduct.quantity - 1)
            : _ticketProduct)
        .where((_ticketProduct) => _ticketProduct.quantity > 0)
        .toList();
    return Ticket(ticketProducts, ticket.userId, id: ticket.id);
  }

  @override
  Ticket genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    // TODO: implement genericToPostgreSQLResultRow
    throw UnimplementedError();
  }
}
