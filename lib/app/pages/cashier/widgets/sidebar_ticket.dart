import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/pages/cashier/cubit/cashier_cubit.dart';
import 'package:total_pos/app/pages/cashier/widgets/sidebar_ticket_product.dart';
import 'package:total_pos/app/pages/login/login.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';

class SidebarTicket extends StatelessWidget {
  const SidebarTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: double.maxFinite,
        width: 300,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 194, 193, 193),
              blurRadius: 10,
              spreadRadius: .5,
              offset: Offset(1, 0))
        ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Ticket',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            IconButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Login.routeName, (route) => false),
                icon: const Icon(Icons.exit_to_app))
          ]),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<CashierCubit, CashierState>(
                      builder: (context, state) {
                    return ListView(children: [
                      for (TicketProduct ticketProduct
                          in state.ticket.ticketProducts)
                        SidebarTicketProduct(ticketProduct,
                            context.read<CashierCubit>().removeTicketProduct)
                    ]);
                  }))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            BlocBuilder<CashierCubit, CashierState>(builder: (context, state) {
              return Text('\$' + state.ticket.total.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20));
            })
          ]),
          const SizedBox(height: 20),
          SizedBox(
              width: double.maxFinite,
              child: BlocBuilder<CashierCubit, CashierState>(
                  builder: (context, state) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: state.ticket.total == 0
                            ? Colors.grey
                            : GlobalConfig.principalColor),
                    onPressed: () => context.read<CashierCubit>().saveTicket(),
                    child: const Icon(Icons.attach_money_rounded));
              }))
        ]));
  }
}
