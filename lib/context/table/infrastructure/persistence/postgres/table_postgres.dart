import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/generic_postgres.dart';
import 'package:total_pos/context/table/domain/table.dart';
import 'package:total_pos/context/table/domain/table_repository.dart';

class TablePostgres extends GenericPostgres<Table> implements TableRepository {
  @override
  Table genericToPostgreSQLResultRow(PostgreSQLResultRow row) {
    return Table(row[2], stringToTableStatus(row[5]),
        id: row[0], accountName: row[4], name: row[1], ticketId: row[3]);
  }
}
