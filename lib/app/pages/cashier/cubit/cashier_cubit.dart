import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/category/domain/category.dart';
import 'package:total_pos/context/category/domain/category_repository.dart';
import 'package:total_pos/context/product/domain/product.dart';
import 'package:total_pos/context/product/domain/product_repository.dart';
import 'package:total_pos/context/ticket/domain/ticket.dart';
import 'package:total_pos/context/ticket/domain/ticket_product.dart';
import 'package:total_pos/context/ticket/domain/ticket_repository.dart';
import 'package:total_pos/context/user/domain/user.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  final _categoryRepository = GetIt.instance.get<CategoryRepository>();
  final _productRepository = GetIt.instance.get<ProductRepository>();
  final _ticketRepository = GetIt.instance.get<TicketRepository>();
  final bool fromTable;

  CashierCubit(User user, this.fromTable) : super(CashierInitial(user)) {
    initCashier();
  }

  setTicket(String ticketID) async {
    final ticket = await _ticketRepository.getByID(ticketID);
    emit(CashierGlobal.copyWith(state, ticket: ticket, updateTicket: true));
  }

  Future<void> initCashier() async {
    final categories = await _categoryRepository.getAll();
    if (categories.isNotEmpty) {
      loadProductsByCategory(categories.first);
    }
    emit(CashierGlobal.copyWith(state, categories: categories));
  }

  Future<void> loadProductsByCategory(Category category) async {
    if (state.currentCategory != null &&
        category.id == state.currentCategory!.id) return;
    final products = await _productRepository.getProductsByCategory(category);
    emit(CashierGlobal.copyWith(state,
        products: products, currentCategory: category));
  }

  Future<void> saveTicket() async {
    if (state.ticket.total == 0) return;
    if (state.updateTicket) {
      await _ticketRepository.update(state.ticket);
    } else {
      await _ticketRepository.create(state.ticket);
    }
  }

  Future<void> addTicketProduct(Product ticketProduct) async {
    final ticket = await _ticketRepository.addTicketProduct(
        state.ticket, TicketProduct(ticketProduct));
    emit(CashierGlobal.copyWith(state, ticket: ticket));
  }

  Future<void> removeTicketProduct(TicketProduct ticketProduct) async {
    final ticket = await _ticketRepository.removeTicketProduct(
        state.ticket, ticketProduct);
    emit(CashierGlobal.copyWith(state, ticket: ticket));
  }
}
