import 'package:uuid/uuid.dart';

class Category {
  final String id;
  final String name;

  Category(this.name, {String? id}) : id = id ?? const Uuid().v4();
}
