import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/pages/admin/screens/products/cubit/product_cubit.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/product/domain/product.dart';

class ProductAdminScreen extends StatelessWidget {
  const ProductAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(),
      child: _ProductAdminView(),
    );
  }
}

class _ProductAdminView extends StatelessWidget {
  final TextEditingController _productNameController =
      TextEditingController(text: '');
  final TextEditingController _productDescripcionController =
      TextEditingController(text: '');
  final TextEditingController _productPrecioController =
      TextEditingController(text: '');

  _ProductAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Productos'),
      Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
              child: TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(label: Text('Nombre')))),
          const SizedBox(width: 50),
          Expanded(
              child: TextFormField(
                  controller: _productPrecioController,
                  decoration: const InputDecoration(label: Text('Precio')))),
          const SizedBox(width: 50),
          Expanded(child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return DropdownButton<Category>(
                hint: const Text('Categoria'),
                isExpanded: true,
                isDense: true,
                value: state.currentCategory,
                onChanged: (category) {
                  if (category != null) {
                    context.read<ProductCubit>().setCurrentCategory(category);
                  }
                },
                items: [
                  for (Category categorie in state.categories)
                    DropdownMenuItem<Category>(
                      value: categorie,
                      child: Text(categorie.name),
                    )
                ],
              );
            },
          ))
        ]),
        TextFormField(
            controller: _productDescripcionController,
            decoration: const InputDecoration(label: Text('Descripcion'))),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              context.read<ProductCubit>().addProduct(
                  _productNameController.text,
                  _productDescripcionController.text,
                  double.tryParse(_productPrecioController.text) ?? 0);
              _productNameController.text = '';
              _productDescripcionController.text = '';
              _productPrecioController.text = '';
            },
            child: const Text('Nuevo Producto'))
      ])),
      Expanded(child:
          BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        return ListView(children: [
          for (Product product in state.products)
            ListTile(title: Text(product.name))
        ]);
      })),
    ]);
  }
}
