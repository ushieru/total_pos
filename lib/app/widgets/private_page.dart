import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/cubit/session_cubit.dart';
import 'package:total_pos/app/pages/login/login.dart';

class PrivatePage extends StatelessWidget {
  final Widget route;
  const PrivatePage({Key? key, required this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
        buildWhen: (previous, current) {
      if (current.user == null && current.redirect) {
        Navigator.pushNamedAndRemoveUntil(
            context, Login.routeName, (route) => false);
      }
      return true;
    }, builder: (context, session) {
      if (session.user == null) return const Login();
      return route;
    });
  }
}
