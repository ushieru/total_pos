import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/shared/application/get_all.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/ticket/infrastructure/persistence/in_memory/ticket_in_memory.dart';

part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final TicketRepository _ticketRepository = TicketInMemory();

  TicketCubit() : super(const TicketGlobal([])) {
    getTickets();
  }

  Future<void> getTickets() async {
    final tickets = await GetAll(_ticketRepository).run();
    emit(TicketGlobal(tickets));
  }
}
