import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/users/cubit/user_cubit.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';

class UserAdminScreen extends StatelessWidget {
  const UserAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: _UserAdminScreenView(),
    );
  }
}

class _UserAdminScreenView extends StatelessWidget {
  final TextEditingController _userNameController =
      TextEditingController(text: '');
  final TextEditingController _userEmailController =
      TextEditingController(text: '');
  final TextEditingController _userUserController =
      TextEditingController(text: '');
  final TextEditingController _userPasswordController =
      TextEditingController(text: '');
  final TextEditingController _userConfirmPasswordController =
      TextEditingController(text: '');

  _UserAdminScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Usuarios'),
      Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(label: Text('Nombre')))),
          const SizedBox(width: 50),
          Expanded(
              child: TextFormField(
                  controller: _userEmailController,
                  decoration: const InputDecoration(label: Text('Email')))),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              child: TextFormField(
                  controller: _userUserController,
                  decoration: const InputDecoration(label: Text('User')))),
          const SizedBox(width: 50),
          Expanded(child:
              BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            return DropdownButton<Role>(
                hint: const Text('Role'),
                isExpanded: true,
                isDense: true,
                value: state.currentRole,
                onChanged: (role) {
                  if (role != null) {
                    context.read<UserCubit>().setCurrentRole(role);
                  }
                },
                items: [
                  for (Role role in Role.values)
                    DropdownMenuItem<Role>(value: role, child: Text(role.name))
                ]);
          }))
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              child: TextFormField(
                  controller: _userPasswordController,
                  decoration:
                      const InputDecoration(label: Text('Contraseña')))),
          const SizedBox(width: 50),
          Expanded(
              child: TextFormField(
                  controller: _userConfirmPasswordController,
                  decoration: const InputDecoration(
                      label: Text('Confirmar Contraseña')))),
        ]),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () => context
                .read<UserCubit>()
                .createUser(
                    _userNameController.text,
                    _userEmailController.text,
                    _userUserController.text,
                    _userPasswordController.text,
                    _userConfirmPasswordController.text)
                .then((_) => {
                      _userNameController.text = '',
                      _userEmailController.text = '',
                      _userUserController.text = '',
                      _userPasswordController.text = '',
                      _userConfirmPasswordController.text = '',
                    }),
            child: const Text('Nuevo Usuario'))
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
