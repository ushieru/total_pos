import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';

class Delete<T> {
  final GenericCrudRepository<T> _repository;
  Delete(this._repository);
  Future<void> run(T object) => _repository.delete(object);
}
