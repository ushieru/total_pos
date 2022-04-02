import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';

class GetAll<T> {
  final GenericCrudRepository<T> _repository;
  GetAll(this._repository);
  Future<List<T>> run() => _repository.getAll();
}
