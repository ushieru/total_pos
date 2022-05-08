import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/cubit/session_cubit.dart';
import 'package:total_pos/app/pages/cashier/cashier.dart';
import 'package:total_pos/app/pages/tables/cubit/table_cubit.dart';
import 'package:total_pos/app/pages/tables/widgets/accounts_grid.dart';
import 'package:total_pos/app/pages/tables/widgets/header.dart';
import 'package:total_pos/app/pages/tables/widgets/login_waiter.dart';
import 'package:total_pos/app/pages/tables/widgets/tables_grid.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';

class Tables extends StatelessWidget {
  static const String routeName = '/tables';
  const Tables({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TableCubit(), child: const _TablesView());
  }
}

class _TablesView extends StatelessWidget {
  const _TablesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
              children: const [Header(), SizedBox(height: 15), TablesGrid()])),
      BlocBuilder<TableCubit, TableState>(buildWhen: (previous, current) {
        if (current is SuccessfulLogin) {
          final sessionCubit = context.read<SessionCubit>();
          sessionCubit.setSession(current.user);
          Navigator.pushNamed(context, Cashier.routeName,
                  arguments: current.currentTable!.ticketId)
              .then((ticket) {
            final cubit = context.read<TableCubit>();
            if (ticket is Ticket) {
              cubit.setCurrentTableOccupied(ticket);
            } else {
              cubit.setCurrentTableEmpty();
            }
            cubit.selectWaiter();
          });
        }
        return true;
      }, builder: (context, state) {
        if (!state.showModal) {
          return const SizedBox();
        }
        return Stack(children: [
          InkWell(
              onTap: () =>
                  context.read<TableCubit>().showModal(showModal: false),
              child: Container(color: Colors.black45)),
          Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.height * 0.9,
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: state.accountSelected == null
                              ? AccountsGrid(accounts: state.accounts)
                              : LoginWaiter(
                                  accountSelected: state.accountSelected!)))))
        ]);
      })
    ]));
  }
}
