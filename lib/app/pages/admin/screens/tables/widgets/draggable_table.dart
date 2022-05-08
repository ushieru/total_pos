import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/pages/admin/screens/tables/cubit/tables_admin_cubit.dart';
import 'package:total_pos/context/table/domain/table.dart' as domain;

class DraggableTable extends StatelessWidget {
  final domain.Table table;
  const DraggableTable({Key? key, required this.table}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
        data: table,
        onDragStarted: () =>
            context.read<TablesAdminCubit>().setDeleteTableAvailable(true),
        onDragEnd: (_) =>
            context.read<TablesAdminCubit>().setDeleteTableAvailable(false),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: GlobalConfig.principalColor,
                border: Border.all(color: Colors.black)),
            child:
                Text(table.name, style: const TextStyle(color: Colors.white))),
        feedback: Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: GlobalConfig.principalColor,
                border: Border.all(color: Colors.black))),
        childWhenDragging: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: GlobalConfig.principalColor.withAlpha(100),
                border: Border.all(color: Colors.black))));
  }
}
