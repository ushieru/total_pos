import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:total_pos/context/account/domain/account.dart';
import 'package:total_pos/context/user/domain/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
}
