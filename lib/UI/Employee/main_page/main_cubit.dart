import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class TkMainCubit extends Cubit<TkMainState> {
  TkMainCubit() : super(const TkMainState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void switchTap(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
