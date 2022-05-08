import 'package:get_it/get_it.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/postgres/account_postgres.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/postgres/category_postgres.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/postgres/product_postgres.dart';
import 'package:total_pos/context/shared/infrastructure/persistence/postgres/postgres_connection.dart';
import 'package:total_pos/context/table/domain/table_repository.dart';
import 'package:total_pos/context/table/infrastructure/persistence/postgres/table_postgres.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/ticket/infrastructure/persistence/postgres/ticket_postgres.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/postgres/user_postgres.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  await PostgresConnection().getConnection();
  getIt.registerSingleton<UserRepository>(UserPostgres());
  getIt.registerSingleton<AccountRepository>(AccountPostgres());
  getIt.registerSingleton<CategoryRepository>(CategoryPostgres());
  getIt.registerSingleton<ProductRepository>(ProdcutPostgres());
  getIt.registerSingleton<TicketRepository>(TicketPostgres());
  getIt.registerSingleton<TableRepository>(TablePostgres());
}
