import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(const AdminInitial());

  void setSideBarItemAndContainer(int sideBarItemselected, Widget container) {
    emit(AdminGlobal(sideBarItemselected, container));
  }
}
