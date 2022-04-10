import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
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
  final ScrollController _scrollController = ScrollController();

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
      const Text('Usuarios',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
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
            return DropdownButton<String>(
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
                    DropdownMenuItem<String>(
                        value: role.name, child: Text(role.name))
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
        BlocBuilder<UserCubit, UserState>(buildWhen: (previous, current) {
          if (current.currentUser != null && current.currentAccount != null) {
            _userNameController.text = current.currentUser!.name;
            _userEmailController.text = current.currentUser!.email;
            _userUserController.text = current.currentAccount!.user;
            _userPasswordController.text = '';
            _userConfirmPasswordController.text = '';
          }
          return true;
        }, builder: (context, state) {
          return Row(children: [
            if (state.currentUser != null)
              Row(children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                        side: BorderSide(
                            color: GlobalConfig.principalColor, width: 2)),
                    onPressed: () async {
                      final cubit = context.read<UserCubit>();
                      cubit.setCurrentRole(null);
                      cubit.setCurrentUser(null);
                      _userNameController.text = '';
                      _userEmailController.text = '';
                      _userUserController.text = '';
                      _userPasswordController.text = '';
                      _userConfirmPasswordController.text = '';
                    },
                    child: Text('Cancelar',
                        style: TextStyle(color: GlobalConfig.principalColor))),
                const SizedBox(width: 10)
              ]),
            ElevatedButton(
                onPressed: () {
                  final cubit = context.read<UserCubit>();
                  if (state.currentUser == null) {
                    cubit.createUser(
                        _userNameController.text,
                        _userEmailController.text,
                        _userUserController.text,
                        _userPasswordController.text,
                        _userConfirmPasswordController.text);
                  } else {
                    cubit.updateUser(
                        _userNameController.text,
                        _userEmailController.text,
                        _userUserController.text,
                        _userPasswordController.text,
                        _userConfirmPasswordController.text);
                  }

                  _userNameController.text = '';
                  _userEmailController.text = '';
                  _userUserController.text = '';
                  _userPasswordController.text = '';
                  _userConfirmPasswordController.text = '';
                },
                child: Text(state.currentUser == null
                    ? 'Nuevo Usuario'
                    : 'Editar Usuario')),
          ]);
        })
      ])),
      const SizedBox(height: 20),
      Expanded(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        return ListView(controller: _scrollController, children: [
          Row(children: const [
            Expanded(
                flex: 2,
                child: Text('Nombre',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                flex: 2,
                child: Text('Email',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                flex: 2,
                child: Text('Role',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                child: Text('Opciones',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 10),
          for (User user in state.users)
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    flex: 2,
                    child:
                        Text(user.name, style: const TextStyle(fontSize: 15))),
                Expanded(
                    flex: 2,
                    child:
                        Text(user.email, style: const TextStyle(fontSize: 15))),
                Expanded(
                    flex: 2,
                    child: Text(user.role,
                        style: const TextStyle(
                            fontSize: 15, overflow: TextOverflow.ellipsis))),
                Expanded(
                    child: Row(children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<UserCubit>().setCurrentRole(user.role);
                        context.read<UserCubit>().setCurrentUser(user);
                      },
                      child: const Icon(Icons.edit)),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () =>
                          context.read<UserCubit>().deleteUser(user),
                      child: const Icon(Icons.delete))
                ]))
              ]),
              const Divider()
            ])
        ]);
      })),
    ]);
  }
}
