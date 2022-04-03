import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/cubit/admin_cubit.dart';
import 'package:total_pos/app/pages/admin/screens/categories/category_admin_screen.dart';
import 'package:total_pos/app/pages/admin/screens/products/product_admin_screen.dart';
import 'package:total_pos/app/pages/admin/screens/users/user_admin_screen.dart';
import 'package:total_pos/app/pages/login/login.dart';

class Admin extends StatelessWidget {
  static const String routeName = '/Admin';
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminCubit(),
      child: const _AdminView(),
    );
  }
}

class _AdminView extends StatelessWidget {
  const _AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 70,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 194, 193, 193),
                    blurRadius: 10,
                    spreadRadius: .5,
                    offset: Offset(1, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Expanded(child: BlocBuilder<AdminCubit, AdminState>(
                      builder: (context, state) {
                    _buildIconButton(int position, String label, IconData icon,
                        Widget container) {
                      final isSelected = state.sideBarItemselected == position;
                      return Column(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            color: isSelected ? Colors.purple : Colors.black,
                            onPressed: () => context
                                .read<AdminCubit>()
                                .setSideBarItemAndContainer(
                                    position, container),
                            icon: Icon(icon),
                          ),
                          Text(
                            label,
                            style: TextStyle(
                                fontSize: 10,
                                color:
                                    isSelected ? Colors.purple : Colors.black),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }

                    return ListView(
                      children: [
                        _buildIconButton(
                          0,
                          'Home',
                          Icons.home_rounded,
                          const SizedBox(),
                        ),
                        _buildIconButton(
                          1,
                          'Categorias',
                          Icons.category_rounded,
                          const CategoryAdminScreen(),
                        ),
                        _buildIconButton(
                          2,
                          'Productos',
                          Icons.shopping_bag_rounded,
                          const ProductAdminScreen(),
                        ),
                        _buildIconButton(
                          3,
                          'Usuarios',
                          Icons.account_circle_rounded,
                          const UserAdminScreen(),
                        ),
                      ],
                    );
                  })),
                  Column(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.exit_to_app),
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, Login.routeName, (route) => false)),
                      const Text('Cerrar sesion',
                          style: TextStyle(fontSize: 10)),
                      const SizedBox(height: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              )),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(50),
              height: double.maxFinite,
              child: BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {
                  return state.container;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
