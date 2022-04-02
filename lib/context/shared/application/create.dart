import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';

class Create<T> {
  final GenericCrudRepository<T> _repository;
  Create(this._repository);
  Future<T> run(T object) => _repository.create(object);
}
