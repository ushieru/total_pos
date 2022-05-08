import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/tables/cubit/table_cubit.dart';
import 'package:total_pos/context/account/domain/account.dart';

class LoginWaiter extends StatelessWidget {
  final textEditingController = TextEditingController();
  final Account accountSelected;
  LoginWaiter({Key? key, required this.accountSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ElevatedButton(
          onPressed: () => context.read<TableCubit>().selectWaiter(),
          child: const Text('Atras')),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
                'Hola ${context.read<TableCubit>().state.accountSelected!.user}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
                obscureText: true,
                controller: textEditingController,
                decoration: const InputDecoration(label: Text('Contraseña'))),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () => context
                    .read<TableCubit>()
                    .loginCurrentWaiter(textEditingController.text),
                child: const Text('Ingresar'))
          ]))
    ]);
  }
}
