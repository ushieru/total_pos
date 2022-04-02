import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/users/cubit/user_cubit.dart';
import 'package:total_pos/context/user/domain/user.dart';

class UserAdminScreen extends StatelessWidget {
  const UserAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: const _UserAdminScreenView(),
    );
  }
}

class _UserAdminScreenView extends StatelessWidget {
  const _UserAdminScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Usuarios'),
      Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(decoration: const InputDecoration(label: Text('Nombre'))),
        TextFormField(decoration: const InputDecoration(label: Text('Email'))),
        TextFormField(decoration: const InputDecoration(label: Text('User'))),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              child: TextFormField(
                  decoration:
                      const InputDecoration(label: Text('Contraseña')))),
          const SizedBox(width: 50),
          Expanded(
              child: TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Confirmar Contraseña')))),
        ]),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {}, child: const Text('Nuevo Producto'))
      ])),
      Expanded(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        return ListView(children: [
          for (User product in state.users) ListTile(title: Text(product.name))
        ]);
      })),
    ]);
  }
}
