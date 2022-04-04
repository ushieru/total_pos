import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/in_memory/account_in_memory.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/in_memory/category_in_memory.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/in_memory/product_in_memory.dart';
import 'package:total_pos/context/shared/application/create.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/in_memory/user_in_memory.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  static bool _isLoaded = false;
  final AccountRepository _accountRepository = AccountInMemory();
  final UserRepository _userRepository = UserInMemory();
  final CategoryRepository _categoryRepository = CategoryInMemory();
  final ProductRepository _productRepository = ProductInMemory();

  LoadingCubit() : super(LoadingInitial()) {
    init();
  }

  Future<void> init() async {
    if (_isLoaded) {
      return emit(LoadingSuccessful());
    }
    final adminAccount = Account('admin', 'admin');
    final userAccount = Account('user', 'user');
    final admin = User('admin', 'admin', Role.admin, adminAccount.id);
    final user = User('user', 'user', Role.user, userAccount.id);
    final breakfastCategory = Category('Desayunos');
    final drinksCategory = Category('Bebidas');
    final products = [
      Product('Chilaquiles', 'Totopos con salsa', 50, breakfastCategory.id),
      Product('Huevo a la mexicana', 'Huevo con tomate, cebolla y chile', 30,
          breakfastCategory.id),
      Product('Hotcakes', 'Pan a la sarten', 20, breakfastCategory.id),
      Product('Cafe', 'Infucion de Granos de cafe', 15, drinksCategory.id),
      Product(
          'Jugo de naranja', 'Jugo natural de naranjas', 15, drinksCategory.id),
    ];
    await Create(_accountRepository).run(adminAccount);
    await Create(_accountRepository).run(userAccount);
    stderr.writeln('<LoadingCubit> Accounts created successful');
    await Create(_userRepository).run(admin);
    await Create(_userRepository).run(user);
    stderr.writeln('<LoadingCubit> Users created successful');
    await Create(_categoryRepository).run(breakfastCategory);
    await Create(_categoryRepository).run(drinksCategory);
    stderr.writeln('<LoadingCubit> Categories created successful');
    await Future.forEach<Product>(products,
        (product) async => await Create(_productRepository).run(product));
    stderr.writeln('<LoadingCubit> Products created successful');
    _isLoaded = true;
    return emit(LoadingSuccessful());
  }
}
