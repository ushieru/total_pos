import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:objectbox/objectbox.dart';
import 'package:total_pos/context/user/domain/user.dart';

@Entity()
class Ticket {
  int id;
  DateTime dateTime = DateTime.now();
  List<TicketProduct> ticketProducts;
  double total;

  final user = ToOne<User>();

  Ticket({
    this.id = 0,
    this.ticketProducts = const [],
    this.total = 0.0,
  });

  Ticket.empty(int userId) : this();

  @override
  String toString() =>
      'Ticket(id: $id, dateTime: $dateTime, ticketProducts: $ticketProducts, total: $total)';
}
