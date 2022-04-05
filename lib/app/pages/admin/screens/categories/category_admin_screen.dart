import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:total_pos/app/config/global_config.dart';
import 'package:total_pos/app/pages/admin/screens/categories/cubit/category_cubit.dart';
import 'package:total_pos/context/category/domain/category.dart';

class CategoryAdminScreen extends StatelessWidget {
  const CategoryAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(),
      child: _CategoryAdminScreenView(),
    );
  }
}

class _CategoryAdminScreenView extends StatelessWidget {
  final TextEditingController _categoryNameController =
      TextEditingController(text: '');

  _CategoryAdminScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Categorias',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
            controller: _categoryNameController,
            decoration: const InputDecoration(label: Text('Nombre'))),
        const SizedBox(height: 10),
        BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
          return Row(children: [
            if (state.currentCategory != null)
              Row(children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                        side: BorderSide(
                            color: GlobalConfig.principalColor, width: 2)),
                    onPressed: () => context
                        .read<CategoryCubit>()
                        .setCurrentCategory(null)
                        .then((_) => _categoryNameController.text = ''),
                    child: Text('Cancelar',
                        style: TextStyle(color: GlobalConfig.principalColor))),
                const SizedBox(width: 10)
              ]),
            ElevatedButton(
                onPressed: () {
                  final cubit = context.read<CategoryCubit>();
                  final category = Category(_categoryNameController.text,
                      id: state.currentCategory?.id);
                  if (state.currentCategory == null) {
                    cubit.addCategory(category);
                  } else {
                    cubit.editCategory(category);
                  }
                  _categoryNameController.text = '';
                  return;
                },
                child: Text(state.currentCategory != null
                    ? 'Editar categoria'
                    : 'Nueva categoria'))
          ]);
        })
      ])),
      const SizedBox(height: 30),
      Expanded(child:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        return ListView(children: [
          Row(children: const [
            Expanded(
                child: Text('Nombre',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Text('Opciones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
          ]),
          const SizedBox(height: 10),
          for (Category category in state.categories)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                      child: Text(category.name,
                          style: const TextStyle(fontSize: 15))),
                  ElevatedButton(
                      onPressed: () => context
                          .read<CategoryCubit>()
                          .setCurrentCategory(category)
                          .then((category) => _categoryNameController.text =
                              category?.name ?? 'Not found'),
                      child: const Icon(Icons.edit)),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () => context
                          .read<CategoryCubit>()
                          .deleteCategory(category),
                      child: const Icon(Icons.delete))
                ]),
                const Divider()
              ],
            )
        ]);
      })),
    ]);
  }
}
