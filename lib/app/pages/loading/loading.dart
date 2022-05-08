import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/setup_locator.dart';
import 'package:total_pos/app/pages/loading/cubit/loading_cubit.dart';
import 'package:total_pos/app/pages/loading/widgets/loading_screen.dart';
import 'package:total_pos/app/pages/login/login.dart';

class Loading extends StatefulWidget {
  static const String routeName = '/Loading';
  const Loading({Key? key}) : super(key: key);
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isConnecting = true;
  Future<void> setConnection() async {
    await setupLocator();
    setState(() => _isConnecting = false);
  }
  @override
  Widget build(BuildContext context) {
    if (_isConnecting) {
      setConnection();
      return const LoadingScreen(text: 'Connecting...');
    }
    return BlocProvider(
        create: (_) => LoadingCubit(), child: const _LoadingView());
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
        buildWhen: (previous, current) {
          if (current is LoadingSuccessful) {
            Navigator.pushNamedAndRemoveUntil(
                context, Login.routeName, (route) => false);
          }
          return true;
        },
        builder: (context, state) =>
            const LoadingScreen(text: 'Get Resources...'));
  }
}
