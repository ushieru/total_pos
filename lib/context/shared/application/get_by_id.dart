import 'package:total_pos/context/shared/domain/generic_crud_repository.dart';

class GetByID<T> {
  final GenericCrudRepository<T> _repository;
  GetByID(this._repository);
  Future<T> run(String id) => _repository.getByID(id);
}
