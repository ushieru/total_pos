abstract class ConnectionManager<T> {
  Future<T> getConnection();
  Future<void> disconnect();
}