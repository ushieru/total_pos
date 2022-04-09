abstract class GenericCrudRepository<T> {
  Future<List<T>> getAll();
  Future<T> getByID(int id);
  Future<T> create(T object);
  Future<List<T>> createMany(List<T> objects);
  Future<T> update(T object);
  Future<void> delete(T object);
}
