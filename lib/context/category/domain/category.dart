import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  int id;
  String name;

  Category({this.id = 0, this.name = ''});

  @override
  String toString() => 'Category(id: $id, name: $name)';
}
