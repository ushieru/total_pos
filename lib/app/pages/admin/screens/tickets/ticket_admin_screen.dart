import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/tickets/cubit/ticket_cubit.dart';
import 'package:total_pos/app/pages/admin/screens/tickets/widgets/ticket_details_modal.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';

class TicketAdminScreen extends StatelessWidget {
  const TicketAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => TicketCubit(), child: _TicketView());
  }
}

class _TicketView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  _TicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tickets',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Expanded(child:
            BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
          return ListView(controller: _scrollController, children: [
            Row(children: const [
              Expanded(
                  flex: 2,
                  child: Text('id',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Expanded(
                  flex: 2,
                  child: Text('Precio',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Expanded(
                  flex: 2,
                  child: Text('Fecha',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Expanded(
                  flex: 2,
                  child: Text('Detalles',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
            ]),
            const SizedBox(height: 10),
            for (Ticket ticket in state.tickets)
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(children: [
                  Expanded(
                      child: Text(ticket.id,
                          style: const TextStyle(fontSize: 15))),
                  Expanded(
                      child: Text('\$' + ticket.total.toString(),
                          style: const TextStyle(fontSize: 15))),
                  Expanded(
                      child: Text(ticket.dateTime.toString().split(' ')[0],
                          style: const TextStyle(
                              fontSize: 15, overflow: TextOverflow.ellipsis))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () => context
                              .read<TicketCubit>()
                              .setCurrentTicket(ticket),
                          child: const Text('Detalles'))),
                ]),
                const Divider()
              ])
          ]);
        }))
      ]),
      BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
        if (state.currentTicket == null) return const SizedBox();
        return TicketDetailsModal(ticket: state.currentTicket!);
      })
    ]);
  }
}
