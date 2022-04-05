import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/cashier/cubit/cashier_cubit.dart';
import 'package:total_pos/context/product/domain/product.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        BlocBuilder<CashierCubit, CashierState>(builder: (context, state) {
      return GridView.count(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 5,
          childAspectRatio: 4,
          shrinkWrap: true,
          children: [
            for (Product product in state.products)
              ElevatedButton(
                  onPressed: () =>
                      context.read<CashierCubit>().addTicketProduct(product),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        Text('\$ ${product.price.toString()}',
                            style: const TextStyle(color: Colors.white)),
                      ]))
          ]);
    }));
  }
}
