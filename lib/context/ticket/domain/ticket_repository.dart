import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';

abstract class TicketRepository implements GenericCrudRepository<Ticket> {
  Future<Ticket> addTicketProduct(Ticket ticket, TicketProduct ticketProduct);
  Future<Ticket> removeTicketProduct(Ticket ticket, TicketProduct ticketProduct);
}
