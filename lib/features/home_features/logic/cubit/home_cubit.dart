import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super((0));

  int indexSlider = 0;

  changeSliders(int index) {
    emit(indexSlider = index);
  }
}
