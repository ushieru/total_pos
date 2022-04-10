import 'package:uuid/uuid.dart';
import '../../shared/domain/serializable.dart';

class Category implements Serializable {
  final String id;
  final String name;
  Category(this.name, {String? id}) : id = id ?? const Uuid().v4();
  @override
  String toString() => 'Category(id: $id, name: $name)';
  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
