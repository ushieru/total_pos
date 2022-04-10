import 'package:get_it/get_it.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/in_memory/account_in_memory.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/postgres/category_postgres.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/in_memory/product_in_memory.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/postgres_connection.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/ticket/infrastructure/persistence/in_memory/ticket_in_memory.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/postgres/user_postgres.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  await PostgresConnection().getConnection();
  getIt.registerSingleton<UserRepository>(UserPostgres());
  getIt.registerSingleton<AccountRepository>(AccountInMemory());
  getIt.registerSingleton<CategoryRepository>(CategoryPostgres());
  getIt.registerSingleton<ProductRepository>(ProductInMemory());
  getIt.registerSingleton<TicketRepository>(TicketInMemory());
}
