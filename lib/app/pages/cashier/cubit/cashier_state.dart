part of 'cashier_cubit.dart';

@immutable
abstract class CashierState {
  final List<Category> categories;
  final List<Product> products;
  final User user;
  final Ticket ticket;
  final Category? currentCategory;
  CashierState(this.categories, this.products, this.user,
      {this.currentCategory, Ticket? ticket})
      : ticket = ticket ?? Ticket.empty(user.id);
}

class CashierInitial extends CashierState {
  CashierInitial(User user) : super([], [], user);
}

class CashierGlobal extends CashierState {
  CashierGlobal(List<Category> categories, List<Product> products, User user,
      {Category? currentCategory, Ticket? ticket})
      : super(categories, products, user,
            currentCategory: currentCategory, ticket: ticket);
}
