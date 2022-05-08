import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/cubit/session_cubit.dart';
import 'package:total_pos/app/pages/admin/admin.dart';
import 'package:total_pos/app/pages/cashier/cashier.dart';
import 'package:total_pos/app/pages/login/cubit/login_cubit.dart';
import 'package:total_pos/app/pages/tables/tables.dart';
import 'package:total_pos/app/utils/image_path.dart';
import 'package:total_pos/context/user/domain/role.dart';

class Login extends StatelessWidget {
  static const String routeName = '/login';

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  final TextEditingController _userController = TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  _LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        if (current is LoginSuccessful) {
          context.read<SessionCubit>().setSession(current.user);
          final String route = stringToRole(current.user.role) == Role.admin
              ? Admin.routeName
              : Cashier.routeName;
          Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
        }
        return true;
      },
      builder: (context, state) {
        return Scaffold(
            body: Row(children: [
          Expanded(
              child: Form(
                  child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                controller: _userController,
                                decoration: const InputDecoration(
                                    label: Text('Usuario'))),
                            TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    label: Text('Contraseña'))),
                            const SizedBox(height: 15),
                            ElevatedButton(
                                onPressed: () => context
                                    .read<LoginCubit>()
                                    .login(_userController.text,
                                        _passwordController.text),
                                child: const Text('Iniciar')),
                            const SizedBox(height: 5),
                            ElevatedButton(
                                onPressed: () =>
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        Tables.routeName, (route) => false),
                                child: const Text('Mapa de mesas'))
                          ])))),
          Expanded(
              child: Container(
                  color: GlobalConfig.principalColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Image(
                              image: AssetImage(
                                  imagePath('Cohort analysis-rafiki.png'))),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ])))
        ]));
      },
    );
  }
}
