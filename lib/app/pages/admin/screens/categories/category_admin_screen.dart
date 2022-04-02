import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      const Text('Categorias'),
      Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
            controller: _categoryNameController,
            decoration: const InputDecoration(label: Text('Nombre'))),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              final category = Category(_categoryNameController.text);
              context.read<CategoryCubit>().addCategory(category);
              _categoryNameController.text = '';
            },
            child: const Text('Nueva categoria'))
      ])),
      Expanded(child:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        return ListView(children: [
          for (Category category in state.categories)
            ListTile(title: Text(category.name))
        ]);
      })),
    ]);
  }
}
