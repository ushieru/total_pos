import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';

class Update<T> {
  final GenericCrudRepository<T> _repository;
  Update(this._repository);
  Future<T> run(T object) => _repository.update(object);
}
