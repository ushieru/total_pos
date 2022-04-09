import 'package:total_pos/context/shared/infrastructure/persistence/connection_mananger.dart';
import 'package:total_pos/objectbox.g.dart';

class ObjectBoxConnection implements ConnectionManager<Store> {
  static Store? _store;

  @override
  disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  getConnection() async {
    return _store ??= await openStore();
  }
}
