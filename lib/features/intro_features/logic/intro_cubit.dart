import 'package:bloc/bloc.dart';

class IntroCubit extends Cubit<int> {
  IntroCubit() : super((0));
  int currentIndex = 0;

  changePage(int index) {
    emit(currentIndex = index);
  }
}
