import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

part 'loading_state.dart';

final getIt = GetIt.instance;

class LoadingCubit extends Cubit<LoadingState> {
  static bool _isLoaded = false;
  final _accountRepository = getIt<AccountRepository>();
  final _userRepository = getIt<UserRepository>();
  final _categoryRepository = getIt<CategoryRepository>();
  final _productRepository = getIt<ProductRepository>();

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
    await _accountRepository.create(adminAccount);
    await _accountRepository.create(userAccount);
    stderr.writeln('<LoadingCubit> Accounts created successful');
    await _userRepository.create(admin);
    await _userRepository.create(user);
    stderr.writeln('<LoadingCubit> Users created successful');
    await _categoryRepository.create(breakfastCategory);
    await _categoryRepository.create(drinksCategory);
    stderr.writeln('<LoadingCubit> Categories created successful');
    await Future.forEach<Product>(
        products, (product) async => await _productRepository.create(product));
    stderr.writeln('<LoadingCubit> Products created successful');
    _isLoaded = true;
    return emit(LoadingSuccessful());
  }
}
