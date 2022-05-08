import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/table/domain/table.dart';
import 'package:total_pos/context/table/domain/table_repository.dart';

part 'tables_admin_state.dart';

class TablesAdminCubit extends Cubit<TablesAdminState> {
  final _accountRepository = GetIt.instance.get<TableRepository>();
  TablesAdminCubit()
      : super(const TablesAdminInitial(
          [],
        )) {
    getTables();
  }

  getTables() async {
    final tables = await _accountRepository.getAll();
    emit(TablesAdminInitial(tables));
  }

  addTable(Table table) async {
    await _accountRepository.create(table);
    getTables();
  }

  updateTable(Table table) async {
    await _accountRepository.update(table);
    getTables();
  }

  setDeleteTableAvailable(bool isAvailable) {
    emit(TablesAdminInitial(state.tables, deleteTableAvailable: isAvailable));
  }

  deleteTable(Table table) async {
    await _accountRepository.delete(table);
    getTables();
  }
}
