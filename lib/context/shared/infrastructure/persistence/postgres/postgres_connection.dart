import 'package:postgres/postgres.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/connection_mananger.dart';

class PostgresConnection extends ConnectionManager<PostgreSQLConnection> {
  final String _host;
  final int _port;
  final String _dbName;
  final String _user;
  final String _password;
  static PostgreSQLConnection? _connection;

  PostgresConnection(this._dbName, this._user, this._password,
      {String host = 'localhost', int port = 5432})
      : _host = host,
        _port = port;

  Future<void> _connect() async {
    _connection = PostgreSQLConnection(_host, _port, _dbName,
        username: _user, password: _password);
    await _connection!.open();
  }

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<PostgreSQLConnection> getConnection() async {
    if (_connection == null) {
      await _connect();
    }
    return _connection!;
  }
}
