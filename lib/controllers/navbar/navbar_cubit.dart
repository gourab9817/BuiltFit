import 'package:flutter_bloc/flutter_bloc.dart';

enum NavbarItem { home, workout, history, settings }

class NavbarCubit extends Cubit<NavbarItem> {
  NavbarCubit() : super(NavbarItem.home);

  void selectItem(NavbarItem item) {
    emit(item);
  }
}
