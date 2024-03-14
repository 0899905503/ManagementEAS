import 'package:bloc/bloc.dart';

class TkMainState {
  final int selectedIndex;

  TkMainState({required this.selectedIndex});
}

class TkMainCubit extends Cubit<TkMainState> {
  TkMainCubit() : super(TkMainState(selectedIndex: 0));

  void loadInitialData() {
    // Logic để load dữ liệu ban đầu nếu cần
  }

  void switchTap(int index) {
    emit(TkMainState(selectedIndex: index));
  }
}
