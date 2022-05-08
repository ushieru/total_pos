import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/tables/cubit/table_cubit.dart';

class TablesGrid extends StatelessWidget {
  const TablesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableCubit, TableState>(
        builder: (context, state) => GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 10,
            shrinkWrap: true,
            children: List.generate(50, (index) {
              try {
                final table = state.tables
                    .firstWhere((element) => element.index == index);
                return ElevatedButton(
                    style: table.accountName.isNotEmpty
                        ? ElevatedButton.styleFrom(primary: Colors.red)
                        : null,
                    onPressed: () {
                      final cubit = context.read<TableCubit>();
                      cubit.showModal();
                      cubit.setCurrentTable(table: table);
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(table.name),
                          if (table.accountName.isNotEmpty)
                            Text(table.accountName)
                        ]));
              } catch (e) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)));
              }
            })));
  }
}
