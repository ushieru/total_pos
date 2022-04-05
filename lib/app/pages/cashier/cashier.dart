import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/cashier/cubit/cashier_cubit.dart';
import 'package:total_pos/app/pages/cashier/widgets/categories.dart';
import 'package:total_pos/app/pages/cashier/widgets/products_grid.dart';
import 'package:total_pos/app/pages/cashier/widgets/sidebar_ticket.dart';

class Cashier extends StatelessWidget {
  static const String routeName = '/cashier';
  const Cashier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CashierCubit(),
      child: const _CashierView(),
    );
  }
}

class _CashierView extends StatelessWidget {
  const _CashierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 10),
                    Categories(),
                    SizedBox(height: 10),
                    Text('Productos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 10),
                    ProductsGrid(),
                  ]))),
      const SidebarTicket()
    ]));
  }
}
