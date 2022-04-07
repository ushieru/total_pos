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
      const Text('Tickets',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      Expanded(child:
          BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
        return ListView(children: [
          Row(children: const [
            Expanded(
                flex: 2,
                child: Text('id',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                flex: 2,
                child: Text('Precio',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                flex: 2,
                child: Text('Descripcion',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 10),
          for (Ticket ticket in state.tickets)
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    flex: 2,
                    child:
                        Text(ticket.id, style: const TextStyle(fontSize: 15))),
                Expanded(
                    flex: 2,
                    child: Text('\$' + ticket.total.toString(),
                        style: const TextStyle(fontSize: 15))),
                const Expanded(
                    flex: 2,
                    child: Text('',
                        style: TextStyle(
                            fontSize: 15, overflow: TextOverflow.ellipsis))),
              ]),
              const Divider()
            ])
        ]);
      })),
    ]);
  }
}
