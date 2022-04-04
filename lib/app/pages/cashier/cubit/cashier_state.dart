part of 'cashier_cubit.dart';

@immutable
abstract class CashierState {
  final List<Category> categories;
  final List<Product> products;
  final Category? currentCategory;
  const CashierState(this.categories, this.products, {this.currentCategory});
}

class CashierInitial extends CashierState {
  CashierInitial() : super([], []);
}

class CashierGlobal extends CashierState {
  const CashierGlobal(List<Category> categories, List<Product> products,
      {Category? currentCategory})
      : super(categories, products, currentCategory: currentCategory);
}
