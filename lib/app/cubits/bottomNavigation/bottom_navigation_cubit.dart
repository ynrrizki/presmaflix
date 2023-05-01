import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<bool> {
  BottomNavigationCubit() : super(false);

  void updateIsHide(bool isHide) => emit(isHide);
}
