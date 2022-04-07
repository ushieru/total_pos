part of 'ticket_cubit.dart';

@immutable
abstract class TicketState {
  final List<Ticket> tickets;
  final Ticket? currentTicket;
  const TicketState(this.tickets, {this.currentTicket});
}

class TicketGlobal extends TicketState {
  const TicketGlobal(List<Ticket> tickets, {Ticket? currentTicket})
      : super(tickets, currentTicket: currentTicket);
}
