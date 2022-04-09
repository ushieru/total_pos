import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  static bool _isLoaded = false;
  final _accountRepository = GetIt.instance<AccountRepository>();
  final _userRepository = GetIt.instance<UserRepository>();
  final _categoryRepository = GetIt.instance<CategoryRepository>();
  final _productRepository = GetIt.instance<ProductRepository>();
  final _ticketRepository = GetIt.instance<TicketRepository>();

  LoadingCubit() : super(LoadingInitial()) {
    init();
  }

  Future<void> init() async {
    if (_isLoaded) {
      return emit(LoadingSuccessful());
    }
    final adminAccount = Account(user: 'admin', password: 'admin');
    final userAccount = Account(user: 'user', password: 'user');
    final admin = User(name: 'admin', email: 'admin', role: 'Admin');
    final user = User(name: 'user', email: 'user', role: 'User');
    final breakfastCategory = Category(name: 'Desayunos');
    final drinksCategory = Category(name: 'Bebidas');
    final products = [
      Product(name: 'Chilaquiles', description: 'Totopos con salsa', price: 50),
      Product(
          name: 'Huevo a la mexicana',
          description: 'Huevo con tomate, cebolla y chile',
          price: 30),
      Product(name: 'Hotcakes', description: 'Pan a la sarten', price: 20),
      Product(
          name: 'Cafe', description: 'Infucion de Granos de cafe', price: 15),
      Product(
          name: 'Jugo de naranja',
          description: 'Jugo natural de naranjas',
          price: 15),
    ];
    // await _accountRepository.create(adminAccount);
    // await _accountRepository.create(userAccount);
    await _userRepository.createMany([
      admin..account.target = adminAccount,
      user..account.target = userAccount
    ]);
    // await _userRepository.create(user..account.target = userAccount);
    await _categoryRepository.create(breakfastCategory);
    await _categoryRepository.create(drinksCategory);
    await Future.forEach<Product>(
        products, (product) async => await _productRepository.create(product));
    // await _ticketRepository.create(
    //     Ticket(products.map((e) => TicketProduct(e)).toList(), user.id));
    _isLoaded = true;
    return emit(LoadingSuccessful());
  }
}
