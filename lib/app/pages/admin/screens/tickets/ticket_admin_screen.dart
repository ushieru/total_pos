import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/tickets/cubit/ticket_cubit.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';

class TicketAdminScreen extends StatelessWidget {
  const TicketAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TicketCubit(), child: const _TicketView());
  }
}

class _TicketView extends StatelessWidget {
  const _TicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Tickets'),
      Expanded(child:
          BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
        return ListView(
            children: [for (Ticket ticket in state.tickets) Text(ticket.id)]);
      })),
    ]);
  }
}
