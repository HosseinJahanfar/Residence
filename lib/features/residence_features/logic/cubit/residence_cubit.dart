import 'package:bloc/bloc.dart';


class ResidenceCubit extends Cubit<int> {
  ResidenceCubit() : super((0));

  int currentIndex = 0;

  changeIndex(index) {
    emit(currentIndex = index);
  }
}
