part of 'tables_admin_cubit.dart';

@immutable
abstract class TablesAdminState {
  final List<Table> tables;
  final bool deleteTableAvailable;
  const TablesAdminState(this.tables, {this.deleteTableAvailable = false});
}

class TablesAdminInitial extends TablesAdminState {
  const TablesAdminInitial(List<Table> tables, {bool? deleteTableAvailable})
      : super(tables, deleteTableAvailable: deleteTableAvailable ?? false);
}
