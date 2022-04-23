import 'dart:convert';
import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:uuid/uuid.dart';

class Ticket implements Serializable {
  final String id;
  final String userId;
  final DateTime dateTime;
  final List<TicketProduct> ticketProducts;
  final double total;
  Ticket(this.ticketProducts, this.userId, {String? id, DateTime? dateTime})
      : dateTime = dateTime ?? DateTime.now(),
        total = ticketProducts.isEmpty
            ? 0
            : ticketProducts
                .map<double>((productTicket) =>
                    productTicket.quantity * productTicket.price)
                .reduce((value, element) => value + element),
        id = id ?? const Uuid().v4();
  Ticket.empty(String userId) : this([], userId);
  @override
  String toString() =>
      'Ticket(id: $id, userId: $userId, dateTime: $dateTime, ticketProducts: $ticketProducts, total: $total)';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'datetime': dateTime.millisecondsSinceEpoch,
      'products': jsonEncode(ticketProducts.map((p) => p.toJson()).toList()),
      'total': total
    };
  }
}
