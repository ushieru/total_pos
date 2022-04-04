import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/category/infrastructure/persistence/in_memory/category_in_memory.dart';
import 'package:total_pos/context/product/applications/get_products_by_category.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/product/infrastructure/persistence/in_memory/product_in_memory.dart';
import 'package:total_pos/context/shared/application/get_all.dart';
import 'package:total_pos/context/ticket/application/add_ticket_product.dart';
import 'package:total_pos/context/ticket/application/remove_ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/ticket/infrastructure/persistence/in_memory/ticket_in_memory.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  final CategoryRepository _categoryRepository = CategoryInMemory();
  final ProductRepository _productRepository = ProductInMemory();
  final TicketRepository _ticketRepository = TicketInMemory();

  CashierCubit() : super(CashierInitial()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await GetAll(_categoryRepository).run();
    emit(CashierGlobal(categories, const []));
    if (categories.isNotEmpty) {
      loadProductsByCategory(categories[0]);
    }
  }

  Future<void> loadProductsByCategory(Category category) async {
    if (state.currentCategory != null &&
        category.id == state.currentCategory!.id) return;
    final products =
        await GetProductsByCategory(_productRepository).run(category);
    emit(CashierGlobal(state.categories, products,
        currentCategory: category, ticket: state.ticket));
  }

  Future<void> addTicketProduct(Product ticketProduct) async {
    final ticket = await AddTicketProduct(_ticketRepository)
        .run(state.ticket, TicketProduct(ticketProduct));
    emit(CashierGlobal(state.categories, state.products,
        currentCategory: state.currentCategory, ticket: ticket));
  }

  Future<void> removeTicketProduct(TicketProduct ticketProduct) async {
    final ticket = await RemoveTicketProduct(_ticketRepository)
        .run(state.ticket, ticketProduct);
    emit(CashierGlobal(state.categories, state.products,
        currentCategory: state.currentCategory, ticket: ticket));
  }
}
