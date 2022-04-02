import 'package:flutter/material.dart';
import 'package:total_pos/app/pages/admin/admin.dart';
import 'package:total_pos/app/pages/login/login.dart';

class TotalPos extends StatelessWidget {
  const TotalPos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Total Pos',
      theme: ThemeData(primarySwatch: Colors.purple),
      routes: {
        Login.routeName: (context) => const Login(),
        Admin.routeName: (context) => const Admin(),
      },
      initialRoute: Login.routeName,
    );
  }
}
