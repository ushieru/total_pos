import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';

class TicketInMemory extends TicketRepository {
  static final Map<String, Ticket> _tickets = <String, Ticket>{};

  @override
  Future<List<Ticket>> getAll() async {
    return _tickets.values.toList();
  }

  @override
  Future<Ticket> getByID(String id) async {
    final product = _tickets[id];
    if (product == null) throw '<TicketInMemory> Product not found';
    return product;
  }

  @override
  Future<Ticket> create(Ticket object) async {
    if (object.total == 0) throw '<TicketInMemory> Ticket is empty';
    if (_tickets.containsKey(object.id)) throw '<TicketInMemory> ID duplicate';
    _tickets[object.id] = object;
    return object;
  }

  @override
  Future<void> delete(Ticket object) async {
    _tickets.remove(object.id);
    return;
  }

  @override
  Future<Ticket> update(Ticket object) async {
    if (!_tickets.containsKey(object.id)) {
      throw '<TicketInMemory> Product not found';
    }
    _tickets[object.id] = object;
    return object;
  }
}
