part of 'cashier_cubit.dart';

@immutable
abstract class CashierState {
  final List<Category> categories;
  final List<Product> products;
  final Ticket ticket;
  final Category? currentCategory;
  CashierState(this.categories, this.products,
      {this.currentCategory, Ticket? ticket})
      : ticket = ticket ?? Ticket.empty();
}

class CashierInitial extends CashierState {
  CashierInitial() : super([], []);
}

class CashierGlobal extends CashierState {
  CashierGlobal(List<Category> categories, List<Product> products,
      {Category? currentCategory, Ticket? ticket})
      : super(categories, products,
            currentCategory: currentCategory, ticket: ticket);
}
