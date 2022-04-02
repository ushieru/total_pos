part of 'admin_cubit.dart';

@immutable
abstract class AdminState {
  final int sideBarItemselected;
  final Widget container;
  const AdminState(this.sideBarItemselected, this.container);
}

class AdminInitial extends AdminState {
  const AdminInitial() : super(-1, const SizedBox());
}

class AdminGlobal extends AdminState {
  const AdminGlobal(int sideBarItemselected, Widget container)
      : super(sideBarItemselected, container);
}
