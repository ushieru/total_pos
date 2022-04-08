import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
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
  final ScrollController _scrollController = ScrollController();

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
      const Text('Productos',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
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
                ]);
          }))
        ]),
        TextFormField(
            controller: _productDescripcionController,
            decoration: const InputDecoration(label: Text('Descripcion'))),
        const SizedBox(height: 10),
        BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          return Row(children: [
            if (state.currentProduct != null)
              Row(children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                        side: BorderSide(
                            color: GlobalConfig.principalColor, width: 2)),
                    onPressed: () async {
                      final cubit = context.read<ProductCubit>();
                      cubit.setCurrentProduct(null);
                      cubit.setCurrentCategory(null);
                      _productNameController.text = '';
                      _productDescripcionController.text = '';
                      _productPrecioController.text = '';
                    },
                    child: Text('Cancelar',
                        style: TextStyle(color: GlobalConfig.principalColor))),
                const SizedBox(width: 10)
              ]),
            ElevatedButton(
                onPressed: () {
                  final cubit = context.read<ProductCubit>();
                  if (state.currentProduct == null) {
                    cubit.addProduct(
                        _productNameController.text,
                        _productDescripcionController.text,
                        double.tryParse(_productPrecioController.text) ?? 0);
                  } else {
                    final currentProduct = state.currentProduct!;
                    cubit.updateProduct(Product(
                        _productNameController.text,
                        _productDescripcionController.text,
                        double.tryParse(_productPrecioController.text) ?? 0,
                        state.currentCategory!.id,
                        id: currentProduct.id));
                  }
                  _productNameController.text = '';
                  _productDescripcionController.text = '';
                  _productPrecioController.text = '';
                },
                child: Text(state.currentProduct != null
                    ? 'Editar Producto'
                    : 'Nuevo Producto')),
          ]);
        })
      ])),
      const SizedBox(height: 20),
      Expanded(child:
          BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        return ListView(controller: _scrollController, children: [
          Row(children: const [
            Expanded(
                flex: 2,
                child: Text('Nombre',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                flex: 2,
                child: Text('Precio',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                flex: 2,
                child: Text('Descripcion',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Expanded(
                child: Text('Opciones',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 10),
          for (Product product in state.products)
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    flex: 2,
                    child: Text(product.name,
                        style: const TextStyle(fontSize: 15))),
                Expanded(
                    flex: 2,
                    child: Text('\$' + product.price.toString(),
                        style: const TextStyle(fontSize: 15))),
                Expanded(
                    flex: 2,
                    child: Text(product.description,
                        style: const TextStyle(
                            fontSize: 15, overflow: TextOverflow.ellipsis))),
                Expanded(
                    child: Row(children: [
                  ElevatedButton(
                      onPressed: () async {
                        final cubit = context.read<ProductCubit>();
                        cubit.setCurrentProduct(product);
                        cubit.setCurrentCategory(state.categories.firstWhere(
                            (_category) => _category.id == product.categoryId));
                        _productNameController.text = product.name;
                        _productDescripcionController.text =
                            product.description;
                        _productPrecioController.text =
                            product.price.toString();
                      },
                      child: const Icon(Icons.edit)),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () =>
                          context.read<ProductCubit>().deleteProduct(product),
                      child: const Icon(Icons.delete))
                ]))
              ]),
              const Divider()
            ])
        ]);
      }))
    ]);
  }
}
