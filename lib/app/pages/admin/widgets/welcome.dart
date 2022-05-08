import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/cubit/session_cubit.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Text('Bienvenido ${state.user!.name}',
              style:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
        );
      },
    );
  }
}
