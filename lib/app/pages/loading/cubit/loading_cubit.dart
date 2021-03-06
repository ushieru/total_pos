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
import 'package:total_pos/context/user/domain/role.dart';
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
    await _userRepository.create(admin);
    await _userRepository.create(user);
    await _categoryRepository.create(breakfastCategory);
    await _categoryRepository.create(drinksCategory);
    await Future.forEach<Product>(
        products, (product) async => await _productRepository.create(product));
    await _ticketRepository.create(
        Ticket(products.map((e) => TicketProduct(e)).toList(), user.id));
    _isLoaded = true;
    return emit(LoadingSuccessful());
  }
}
