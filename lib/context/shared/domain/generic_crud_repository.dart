abstract class GenericCrudRepository<T> {
  Future<List<T>> getAll();
  Future<T> getByID(String id);
  Future<T> create(T t);
  Future<T> update(T t);
  Future<void> delete(T t);
}
