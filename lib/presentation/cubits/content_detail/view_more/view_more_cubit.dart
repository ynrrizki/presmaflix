import 'package:bloc/bloc.dart';

class ViewMoreCubit extends Cubit<bool> {
  ViewMoreCubit() : super(false);

  void updateViewMore(bool isMore) => emit(isMore);
}
