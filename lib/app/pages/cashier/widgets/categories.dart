import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/cashier/cubit/cashier_cubit.dart';
import 'package:total_pos/context/category/domain/category.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Categorias',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      const SizedBox(height: 10),
      SizedBox(
          height: 30,
          child: BlocBuilder<CashierCubit, CashierState>(
              builder: (context, state) {
            return ListView(scrollDirection: Axis.horizontal, children: [
              for (Category category in state.categories)
                Container(
                    height: 30,
                    width: 120,
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: category.id == state.currentCategory?.id
                                ? 5
                                : 0),
                        onPressed: () => context
                            .read<CashierCubit>()
                            .loadProductsByCategory(category),
                        child: Text(category.name)))
            ]);
          }))
    ]);
  }
}
