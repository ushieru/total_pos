import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/login/login.dart';
import 'package:total_pos/app/pages/tables/cubit/table_cubit.dart';
import 'package:total_pos/context/user/domain/role.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black12)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, Login.routeName, (route) => false),
              child: const Text('Atras')),
          PopupMenuButton(
              onSelected: (Role selectedValue) =>
                  context.read<TableCubit>().getAccounts(role: selectedValue),
              itemBuilder: (BuildContext ctx) => const [
                    PopupMenuItem(child: Text('Meseros'), value: Role.waiter),
                    PopupMenuItem(child: Text('Cajeros'), value: Role.cashier),
                  ])
        ]));
  }
}
