import 'package:total_pos/context/shared/domain/serializable.dart';
import 'package:uuid/uuid.dart';

class Table implements Serializable {
  final String id;
  final String name;
  final int index;
  final String ticketId;
  final String accountName;
  final TableStatus status;
  Table(this.index, this.status,
      {this.name = '', String? id, this.ticketId = '', this.accountName = ''})
      : id = id ?? const Uuid().v4();
  copyWith(
      {String? id,
      String? name,
      int? index,
      String? ticketId,
      String? accountName,
      TableStatus? status}) {
    return Table(index ?? this.index, status ?? this.status,
        id: id ?? this.id,
        name: name ?? this.name,
        ticketId: ticketId ?? this.ticketId,
        accountName: accountName ?? this.accountName);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'index': index,
      'ticketId': ticketId,
      'accountName': accountName,
      'status': status.name
    };
  }
}

enum TableStatus { available, occupied }

TableStatus stringToTableStatus(String status) {
  switch (status) {
    case 'available':
      return TableStatus.available;
    case 'occupied':
      return TableStatus.occupied;
    default:
      return TableStatus.available;
  }
}
