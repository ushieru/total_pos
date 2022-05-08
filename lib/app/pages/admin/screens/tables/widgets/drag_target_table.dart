import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/tables/cubit/tables_admin_cubit.dart';
import 'package:total_pos/context/table/domain/table.dart' as domain;

class DragTargetTable extends StatelessWidget {
  final int index;
  const DragTargetTable({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget(builder: (context, candidateData, rejectedData) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.black12)));
    }, onAccept: (data) {
      if (data is domain.Table) {
        final table =
            domain.Table(index, data.status, id: data.id, name: data.name);
        context.read<TablesAdminCubit>().updateTable(table);
      }
    });
  }
}
