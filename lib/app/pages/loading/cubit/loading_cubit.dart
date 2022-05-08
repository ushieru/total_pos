import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/table/domain/table.dart';
import 'package:total_pos/context/table/domain/table_repository.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/postgres_connection.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/user/domain/role.dart';
import 'package:total_pos/context/user/domain/user.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  final _accountRepository = GetIt.instance<AccountRepository>();
  final _userRepository = GetIt.instance<UserRepository>();
  final _categoryRepository = GetIt.instance<CategoryRepository>();
  final _productRepository = GetIt.instance<ProductRepository>();
  final _ticketRepository = GetIt.instance<TicketRepository>();
  final _tableRepository = GetIt.instance<TableRepository>();

  LoadingCubit() : super(LoadingInitial()) {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('_isLoaded') ?? false) {
      return emit(LoadingSuccessful());
    }
    final sql =
        await rootBundle.loadString('lib/backend/assets/postgres/dump_db.sql');
    final connection = await PostgresConnection().getConnection();
    await connection.execute(sql);
    final adminAccount = Account('admin', 'admin');
    final userAccount = Account('cashier', 'cashier');
    final waiterAccount = Account('waiter', 'waiter');
    final admin = User(
        name: 'admin',
        email: 'admin',
        role: Role.admin.name,
        accountId: adminAccount.id);
    final user = User(
        name: 'cashier',
        email: 'cashier',
        role: Role.cashier.name,
        accountId: userAccount.id);
    final waiter = User(
        name: 'waiter',
        email: 'waiter',
        role: Role.waiter.name,
        accountId: waiterAccount.id);
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
    await _accountRepository.create(waiterAccount);
    await _userRepository.create(admin);
    await _userRepository.create(user);
    await _userRepository.create(waiter);
    await _categoryRepository.create(breakfastCategory);
    await _categoryRepository.create(drinksCategory);
    await Future.forEach<Product>(
        products, (product) async => await _productRepository.create(product));
    var ticket = Ticket([], user.id);
    final ticketProducts =
        products.map((product) => TicketProduct(product)).toList();
    for (var ticketProduct in ticketProducts) {
      ticket = await _ticketRepository.addTicketProduct(ticket, ticketProduct);
    }
    await _ticketRepository.create(ticket);
    for (var i = 0; i < 6; i++) {
      final table = Table(i, TableStatus.available, name: 'Mesa $i');
      await _tableRepository.create(table);
    }
    await prefs.setBool('_isLoaded', true);
    return emit(LoadingSuccessful());
  }
}
