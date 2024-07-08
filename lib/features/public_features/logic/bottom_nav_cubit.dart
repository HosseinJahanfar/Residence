import 'package:bloc/bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super((0));

  int screenIndex = 0;

  onTabScreen(int index) {
    emit(screenIndex = index);
  }
}
