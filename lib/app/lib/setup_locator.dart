import 'package:get_it/get_it.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/in_memory/account_in_memory.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/in_memory/category_in_memory.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/in_memory/product_in_memory.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/ticket/infrastructure/persistence/in_memory/ticket_in_memory.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/in_memory/user_in_memory.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<UserRepository>(UserInMemory());
  getIt.registerSingleton<AccountRepository>(AccountInMemory());
  getIt.registerSingleton<CategoryRepository>(CategoryInMemory());
  getIt.registerSingleton<ProductRepository>(ProductInMemory());
  getIt.registerSingleton<TicketRepository>(TicketInMemory());
}
