import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/tickets/cubit/ticket_cubit.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';

class TicketDetailsModal extends StatelessWidget {
  final Ticket ticket;
  const TicketDetailsModal({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCubit, TicketState>(
      builder: (context, state) {
        return SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ClipRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Center(
                        child: Container(
                            width: 600,
                            height: 400,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Column(
                              children: [
                                Row(children: [
                                  Expanded(
                                      child: Text(
                                          ticket.user.target?.id.toString() ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))),
                                  ElevatedButton(
                                      onPressed: () => context
                                          .read<TicketCubit>()
                                          .setCurrentTicket(null),
                                      child: const Text('Cerrar')),
                                ]),
                                const SizedBox(height: 10),
                                Row(children: const [
                                  Expanded(
                                      child: Text('Nombre',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600))),
                                  Expanded(
                                      child: Text('Precio',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600))),
                                  Expanded(
                                      child: Text('Cantidad',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600))),
                                ]),
                                const SizedBox(height: 10),
                                Expanded(child: _TicketDetails(ticket: ticket))
                              ],
                            ))))));
      },
    );
  }
}

class _TicketDetails extends StatelessWidget {
  final _scrollController = ScrollController();
  final Ticket ticket;
  _TicketDetails({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(controller: _scrollController, children: [
      for (TicketProduct ticketProduct in ticket.ticketProducts)
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                  child: Text(ticketProduct.product.target?.name ?? '',
                      style: const TextStyle(fontSize: 15))),
              Expanded(
                  child: Text('\$ ${ticketProduct.product.target?.price ?? 0}',
                      style: const TextStyle(fontSize: 15))),
              Expanded(
                  child: Text(ticketProduct.quantity.toString(),
                      style: const TextStyle(fontSize: 15)))
            ],
          )
        ]),
    ]);
  }
}
