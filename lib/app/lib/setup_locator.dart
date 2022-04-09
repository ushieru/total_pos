import 'package:get_it/get_it.dart';
import 'package:total_pos/context/account/domain/account_repository.dart';
import 'package:total_pos/context/account/infrastructure/persistence/object_box/account_object_box.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/object_box/category_object_box.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/object_box/product_object_box.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/ticket/infrastructure/persistence/object_box/ticket_object_box.dart';
import 'package:total_pos/context/user/domain/user_repository.dart';
import 'package:total_pos/context/user/infrastructure/persistence/object_box/user_object_box.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<UserRepository>(UserObjectBox());
  await Future.delayed(const Duration(seconds: 1));
  getIt.registerSingleton<AccountRepository>(AccountObjectBox());
  getIt.registerSingleton<CategoryRepository>(CategoryObjectBox());
  getIt.registerSingleton<ProductRepository>(ProductObjectBox());
  getIt.registerSingleton<TicketRepository>(TicketObjectBox());
}
