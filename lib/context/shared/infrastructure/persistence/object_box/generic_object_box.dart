import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/object_box/object_box_connection.dart';
import 'package:total_pos/objectbox.g.dart';

class GenericObjectBox<T extends dynamic> implements GenericCrudRepository<T> {
  late final Box<T> _box;

  GenericObjectBox() {
    _connect();
  }

  Future<void> _connect() async {
    final store = await ObjectBoxConnection().getConnection();
    _box = Box<T>(store);
  }

  @override
  Future<T> create(T obj) async {
    _box.put(obj);
    return obj;
  }

  @override
  Future<List<T>> createMany(List<T> obj) async {
    _box.putMany(obj);
    return obj;
  }

  @override
  Future<void> delete(T user) async {
    _box.remove(user.id);
  }

  @override
  Future<List<T>> getAll() async {
    return _box.getAll();
  }

  @override
  Future<T> getByID(int id) async {
    final user = _box.get(id);
    if (user == null) throw '<TObjectBox> T not found';
    return user;
  }

  @override
  Future<T> update(T user) async {
    _box.put(user);
    return user;
  }
}
