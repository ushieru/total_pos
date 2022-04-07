import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final _ticketRepository = GetIt.instance.get<TicketRepository>();

  TicketCubit() : super(const TicketGlobal([])) {
    getTickets();
  }

  Future<void> getTickets() async {
    final tickets = await _ticketRepository.getAll();
    emit(TicketGlobal(tickets));
  }

  Future<void> setCurrentTicket(Ticket? ticket) async {
    emit(TicketGlobal(state.tickets, currentTicket: ticket));
  }
}
