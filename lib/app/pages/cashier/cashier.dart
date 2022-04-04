import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/cashier/cubit/cashier_cubit.dart';
import 'package:total_pos/app/pages/login/login.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/product/domain/product.dart';

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
                  children: [
                    const SizedBox(height: 10),
                    const Text('Categorias',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 30,
                        child: BlocBuilder<CashierCubit, CashierState>(
                            builder: (context, state) {
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (Category category in state.categories)
                                  Container(
                                      height: 30,
                                      width: 120,
                                      margin: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                          onPressed: () => context
                                              .read<CashierCubit>()
                                              .loadProductsByCategory(category),
                                          child: Text(category.name)))
                              ]);
                        })),
                    const SizedBox(height: 10),
                    const Text('Productos',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 10),
                    Expanded(child: BlocBuilder<CashierCubit, CashierState>(
                      builder: (context, state) {
                        return GridView.count(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 5,
                            childAspectRatio: 3,
                            shrinkWrap: true,
                            children: [
                              for (Product product in state.products)
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      product.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))
                            ]);
                      },
                    ))
                  ]))),
      Container(
          padding: const EdgeInsets.all(10),
          height: double.maxFinite,
          width: 300,
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    child: Column(children: const []))),
            const Text('Total:'),
            const Text('Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.attach_money_rounded))),
              const SizedBox(width: 10),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Icon(Icons.credit_card)))
            ]),
          ]))
    ]));
  }
}
