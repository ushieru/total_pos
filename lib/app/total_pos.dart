import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/cubit/session_cubit.dart';
import 'package:total_pos/app/pages/admin/admin.dart';
import 'package:total_pos/app/pages/cashier/cashier.dart';
import 'package:total_pos/app/pages/loading/loading.dart';
import 'package:total_pos/app/pages/login/login.dart';
import 'package:total_pos/app/pages/tables/tables.dart';
import 'package:total_pos/app/widgets/private_page.dart';

class TotalPos extends StatelessWidget {
  const TotalPos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit(),
      child: MaterialApp(
        title: 'Total Pos',
        theme: ThemeData(primarySwatch: GlobalConfig.principalColor),
        routes: {
          Loading.routeName: (context) => const Loading(),
          Login.routeName: (context) => const Login(),
          Admin.routeName: (context) => const PrivatePage(route: Admin()),
          Cashier.routeName: (context) => const PrivatePage(route: Cashier()),
          Tables.routeName: (context) => const Tables(),
        },
        initialRoute: Loading.routeName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
