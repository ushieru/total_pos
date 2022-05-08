part of 'table_cubit.dart';

@immutable
abstract class TableState {
  final List<Table> tables;
  final List<Account> accounts;
  final bool showModal;
  final Account? accountSelected;
  final Table? currentTable;
  const TableState(this.tables, this.accounts, this.showModal,
      {this.accountSelected, this.currentTable});
}

class TableInitial extends TableState {
  const TableInitial(List<Table> tables, List<Account> accounts,
      {bool showModal = false, Account? accountSelected, Table? currentTable})
      : super(tables, accounts, showModal,
            accountSelected: accountSelected, currentTable: currentTable);
  static copyWith(TableState state,
      {List<Table>? tables,
      List<Account>? accounts,
      bool? showModal,
      Account? accountSelected,
      Table? currentTable}) {
    return TableInitial(tables ?? state.tables, accounts ?? state.accounts,
        showModal: showModal ?? state.showModal,
        accountSelected: accountSelected,
        currentTable: currentTable);
  }
}

class SuccessfulLogin extends TableState {
  final User user;
  SuccessfulLogin(this.user, TableState tableInitial)
      : super(tableInitial.tables, tableInitial.accounts, false,
            accountSelected: tableInitial.accountSelected,
            currentTable: tableInitial.currentTable);
}
