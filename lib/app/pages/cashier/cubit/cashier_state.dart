part of 'cashier_cubit.dart';

@immutable
abstract class CashierState {
  final List<Category> categories;
  final List<Product> products;
  final User user;
  final Ticket ticket;
  final bool updateTicket;
  final Category? currentCategory;
  CashierState(this.categories, this.products, this.user,
      {this.currentCategory, Ticket? ticket, this.updateTicket = false})
      : ticket = ticket ?? Ticket.empty(user.id);
}

class CashierInitial extends CashierState {
  CashierInitial(User user) : super([], [], user);
}

class CashierGlobal extends CashierState {
  CashierGlobal(List<Category> categories, List<Product> products, User user,
      {Category? currentCategory,
      Ticket? ticket,
      bool updateTicket = false,
      bool fromTable = false})
      : super(categories, products, user,
            currentCategory: currentCategory,
            ticket: ticket,
            updateTicket: updateTicket);
  static copyWith(CashierState state,
      {Category? currentCategory,
      Ticket? ticket,
      bool? updateTicket,
      List<Category>? categories,
      List<Product>? products}) {
    return CashierGlobal(
        categories ?? state.categories, products ?? state.products, state.user,
        currentCategory: currentCategory ?? state.currentCategory,
        ticket: ticket ?? state.ticket,
        updateTicket: updateTicket ?? state.updateTicket);
  }
}
