import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/table/domain/table.dart';
import 'package:total_pos/context/table/domain/table_repository.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  final _tableRepository = GetIt.instance.get<TableRepository>();
  final _accountRepository = GetIt.instance.get<AccountRepository>();
  final _userRepository = GetIt.instance.get<UserRepository>();

  TableCubit() : super(const TableInitial([], [])) {
    getTables();
  }

  getTables() async {
    final tables = await _tableRepository.getAll();
    getAccounts();
    emit(TableInitial.copyWith(state, tables: tables));
  }

  getAccounts({Role role = Role.waiter}) async {
    final accounts = await _accountRepository.getAccountsByRole(role);
    emit(TableInitial.copyWith(state, accounts: accounts));
  }

  selectWaiter({Account? account}) {
    emit(TableInitial.copyWith(state,
        accountSelected: account, currentTable: state.currentTable));
  }

  setCurrentTable({Table? table}) {
    emit(TableInitial.copyWith(state, currentTable: table));
  }

  setCurrentTableOccupied(Ticket ticket) async {
    final newTable = state.currentTable!.copyWith(
        status: TableStatus.occupied,
        ticketId: ticket.id,
        accountName: state.accountSelected!.user);
    await _tableRepository.update(newTable);
    setCurrentTable();
    getTables();
  }

  setCurrentTableEmpty() async {
    final currentTable = state.currentTable!;
    final newTable = Table(currentTable.index, TableStatus.available,
        name: currentTable.name, id: currentTable.id);
    await _tableRepository.update(newTable);
    setCurrentTable();
    getTables();
  }

  showModal({bool showModal = true}) {
    if (showModal) {
      return emit(TableInitial.copyWith(state,
          showModal: showModal,
          accountSelected: state.accountSelected,
          currentTable: state.currentTable));
    }
    emit(TableInitial(state.tables, state.accounts));
  }

  loginCurrentWaiter(String password) async {
    final account = await _accountRepository.getAccountByUserAndPassword(
        state.accountSelected!.user, password);
    final user = await _userRepository.getUserByAccount(account);
    if (user.role == 'waiter' &&
        state.currentTable!.accountName.isNotEmpty &&
        state.currentTable!.accountName != account.user) return;
    emit(SuccessfulLogin(user, state));
  }
}
