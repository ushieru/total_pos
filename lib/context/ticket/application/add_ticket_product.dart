import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

class AddTicketProduct {
  final TicketRepository _repository;
  AddTicketProduct(this._repository);
  Future<Ticket> run(Ticket ticket, TicketProduct ticketProduct) =>
      _repository.addTicketProduct(ticket, ticketProduct);
}
