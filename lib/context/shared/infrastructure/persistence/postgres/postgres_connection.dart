import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/connection_mananger.dart';

class PostgresConnection extends ConnectionManager<PostgreSQLConnection> {
  final String host;
  final int port;
  final String dbName;
  final String user;
  final String password;
  static PostgreSQLConnection? _connection;

  PostgresConnection(
      {this.dbName = 'total_pos',
      this.user = 'postgres',
      this.password = 'postgres',
      this.host = 'localhost',
      this.port = 5432});

  Future<PostgreSQLConnection> _connect() async {
    final connection = PostgreSQLConnection(host, port, dbName,
        username: user, password: password);
    await connection.open();
    return connection;
  }

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  getConnection() async {
    return _connection ??= await _connect();
  }
}
