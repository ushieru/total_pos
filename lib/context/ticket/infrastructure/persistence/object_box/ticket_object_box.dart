import 'package:total_pos/context/shared/infrastructure/persistence/object_box/generic_object_box.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

class TicketObjectBox extends GenericObjectBox<Ticket>
    implements TicketRepository {
  @override
  Future<Ticket> addTicketProduct(Ticket ticket, TicketProduct ticketProduct) {
    // TODO: implement addTicketProduct
    throw UnimplementedError();
  }

  @override
  Future<Ticket> removeTicketProduct(
      Ticket ticket, TicketProduct ticketProduct) {
    // TODO: implement removeTicketProduct
    throw UnimplementedError();
  }
}
