import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/tables/cubit/tables_admin_cubit.dart';
import 'package:total_pos/app/pages/admin/screens/tables/widgets/drag_target_table.dart';
import 'package:total_pos/app/pages/admin/screens/tables/widgets/draggable_table.dart';
import 'package:total_pos/app/pages/admin/screens/tables/widgets/header_table.dart';

class TablesAdminScreen extends StatelessWidget {
  const TablesAdminScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TablesAdminCubit(),
        child: const _TablesAdminScreenView());
  }
}

class _TablesAdminScreenView extends StatelessWidget {
  const _TablesAdminScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: BlocBuilder<TablesAdminCubit, TablesAdminState>(
                builder: (context, state) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HeaderTable(),
                          GridView.count(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 10,
                              shrinkWrap: true,
                              children: List.generate(50, (index) {
                                try {
                                  final table = state.tables.firstWhere(
                                      (element) => element.index == index);
                                  return DraggableTable(table: table);
                                } catch (e) {
                                  return DragTargetTable(index: index);
                                }
                              }))
                        ]))));
  }
}
