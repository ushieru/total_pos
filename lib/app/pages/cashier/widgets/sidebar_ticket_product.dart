import 'package:flutter/material.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';

class SidebarTicketProduct extends StatelessWidget {
  final TicketProduct ticketProduct;
  final Future<void> Function(TicketProduct ticketProduct) removeTicketProduct;

  const SidebarTicketProduct(this.ticketProduct, this.removeTicketProduct,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: Text(ticketProduct.product.target?.name ?? '',
                style: const TextStyle(
                    fontSize: 20, overflow: TextOverflow.ellipsis))),
        SizedBox(
          child: ElevatedButton(
              onPressed: () => removeTicketProduct(ticketProduct),
              child: Icon(
                  ticketProduct.quantity == 1 ? Icons.delete : Icons.remove)),
        )
      ]),
      const SizedBox(height: 2),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('x ${ticketProduct.quantity.toString()}',
            style: const TextStyle(fontSize: 20)),
        Text(
            '\$' +
                (ticketProduct.quantity *
                        (ticketProduct.product.target?.price ?? 0))
                    .toString(),
            style: const TextStyle(fontSize: 20))
      ]),
      const Divider(),
      const SizedBox(height: 5)
    ]);
  }
}
