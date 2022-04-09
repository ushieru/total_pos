import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/cubit/session_cubit.dart';
import 'package:total_pos/app/pages/admin/admin.dart';
import 'package:total_pos/app/pages/cashier/cashier.dart';
import 'package:total_pos/app/pages/login/cubit/login_cubit.dart';

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
          final String route = current.user.role == 'Admin'
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
                                decoration:
                                    const InputDecoration(label: Text('User'))),
                            TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    label: Text('Password'))),
                            const SizedBox(height: 15),
                            ElevatedButton(
                                onPressed: () => context
                                    .read<LoginCubit>()
                                    .login(_userController.text,
                                        _passwordController.text),
                                child: const Text('Submit')),
                          ])))),
          Expanded(
              child: Container(
                  color: GlobalConfig.principalColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [],
                  ))),
        ]));
      },
    );
  }
}
