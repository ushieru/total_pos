import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

class RemoveTicketProduct {
  final TicketRepository _repository;
  RemoveTicketProduct(this._repository);
  Future<Ticket> run(Ticket ticket, TicketProduct ticketProduct) =>
      _repository.removeTicketProduct(ticket, ticketProduct);
}
