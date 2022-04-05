import 'package:flutter/material.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/pages/admin/admin.dart';
import 'package:total_pos/app/pages/cashier/cashier.dart';
import 'package:total_pos/app/pages/loading/loading.dart';
import 'package:total_pos/app/pages/login/login.dart';

class TotalPos extends StatelessWidget {
  const TotalPos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Pos',
      theme: ThemeData(primarySwatch: GlobalConfig.principalColor),
      routes: {
        Loading.routeName: (context) => const Loading(),
        Login.routeName: (context) => const Login(),
        Admin.routeName: (context) => const Admin(),
        Cashier.routeName: (context) => const Cashier(),
      },
      initialRoute: Loading.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
