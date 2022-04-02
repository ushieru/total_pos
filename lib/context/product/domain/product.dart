import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final String descripcion;
  final double price;
  final String categoryId;

  Product(this.name, this.descripcion, this.price, this.categoryId)
      : id = const Uuid().v4();
}
