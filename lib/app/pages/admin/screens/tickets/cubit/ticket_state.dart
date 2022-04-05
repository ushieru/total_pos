part of 'ticket_cubit.dart';

@immutable
abstract class TicketState {
  final List<Ticket> tickets;
  const TicketState(this.tickets);
}

class TicketGlobal extends TicketState {
  const TicketGlobal(List<Ticket> tickets) : super(tickets);
}
