import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/tables/cubit/tables_admin_cubit.dart';
import 'package:total_pos/context/table/domain/table.dart' as domain;

class HeaderTable extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  HeaderTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: 150,
          child: TextFormField(
              controller: _textEditingController,
              decoration:
                  const InputDecoration(label: Text('Nombre de la mesa')))),
      const SizedBox(width: 30),
      SizedBox(
          width: 100,
          child: ElevatedButton(
              onPressed: () {
                final cubit = context.read<TablesAdminCubit>();
                cubit.addTable(domain.Table(getNextIndex(cubit.state.tables),
                    domain.TableStatus.available,
                    name: _textEditingController.text));
                _textEditingController.text = '';
              },
              child: const Text('New Table'))),
      const SizedBox(width: 10),
      if (context.select((TablesAdminCubit c) => c.state.deleteTableAvailable))
        SizedBox(
            width: 100,
            child: DragTarget(
              builder: (context, _, __) => ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text('Delete')),
              onAccept: (domain.Table table) =>
                  context.read<TablesAdminCubit>().deleteTable(table),
            )),
    ]);
  }
}

int getNextIndex(List<domain.Table> tables) {
  if (tables.length == 50) throw Exception('Table limit reached');
  int nextIndex = 0;
  for (int i = 0; i < 50; i++) {
    if (tables.any((element) => element.index == i)) {
      continue;
    } else {
      nextIndex = i;
      break;
    }
  }
  return nextIndex;
}
