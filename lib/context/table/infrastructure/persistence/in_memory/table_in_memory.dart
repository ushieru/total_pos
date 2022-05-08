import 'package:total_pos/context/table/domain/table.dart';
import 'package:total_pos/context/table/domain/table_repository.dart';

class TableInMemory extends TableRepository {
  static final Map<String, Table> _tickets = <String, Table>{
    'b271ec94-7ce8-4f5b-a017-15ae527097fd': Table(0, TableStatus.available,
        id: 'b271ec94-7ce8-4f5b-a017-15ae527097fd', name: 'Mesa 1'),
    '4a7d3d0b-e987-415f-bcaa-ce49c0c5313d': Table(1, TableStatus.available,
        id: '4a7d3d0b-e987-415f-bcaa-ce49c0c5313d', name: 'Mesa 2'),
    '6c868462-9384-48fa-a107-8ca54d72ae82': Table(2, TableStatus.available,
        id: '6c868462-9384-48fa-a107-8ca54d72ae82', name: 'Mesa 3'),
    '0ac32c47-df50-4fe7-8a8c-7783a5a6d077': Table(3, TableStatus.available,
        id: '0ac32c47-df50-4fe7-8a8c-7783a5a6d077', name: 'Mesa 4'),
    'b4d9ecfb-1674-4d0c-9c45-6e10dc7ca242': Table(4, TableStatus.available,
        id: 'b4d9ecfb-1674-4d0c-9c45-6e10dc7ca242', name: 'Mesa 5'),
  };

  @override
  Future<List<Table>> getAll() async {
    return _tickets.values.toList();
  }

  @override
  Future<Table> getByID(String id) async {
    final product = _tickets[id];
    if (product == null) throw '<TableInMemory> Product not found';
    return product;
  }

  @override
  Future<Table> create(Table object) async {
    if (_tickets.containsKey(object.id)) throw '<TableInMemory> ID duplicate';
    _tickets[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(Table object) async {
    _tickets.remove(object.id);
    return;
  }

  @override
  Future<Table> update(Table object) async {
    if (!_tickets.containsKey(object.id)) {
      throw '<TableInMemory> Product not found';
    }
    _tickets[object.id] = object;
    return object;
  }
}
